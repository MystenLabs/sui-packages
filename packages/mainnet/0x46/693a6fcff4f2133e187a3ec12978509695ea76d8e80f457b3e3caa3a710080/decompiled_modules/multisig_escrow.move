module 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow {
    struct MULTISIG_ESCROW has drop {
        dummy_field: bool,
    }

    struct Listings has store, key {
        id: 0x2::object::UID,
        signer_public_key: vector<u8>,
        fee_recipient: address,
        fee_rate: u64,
        warranty_price_recipient: address,
        supporting_coin_types: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        seller: address,
        coin_type_name: 0x1::string::String,
        min_price: u64,
        item: 0x1::option::Option<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>,
    }

    struct Bid has store, key {
        id: 0x2::object::UID,
        buyer: address,
        price: u64,
        listing_id: 0x2::object::ID,
    }

    struct Escrow<phantom T0> has store, key {
        id: 0x2::object::UID,
        listing: Listing,
        bid: Bid,
        operator: address,
        payment: 0x1::option::Option<0x2::coin::Coin<T0>>,
        fulfilled: bool,
        fee_recipient: address,
        fee_amount: u64,
        buyer_warranty: 0x1::option::Option<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::Warranty>,
        warranty_price_recipient: address,
    }

    struct ListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        coin_type_name: 0x1::string::String,
        min_price: u64,
        item_id: 0x2::object::ID,
    }

    struct ListingCanceled has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        item_id: 0x2::object::ID,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        bid_id: 0x2::object::ID,
        buyer_address: address,
        coin_type_name: 0x1::string::String,
        price: u64,
        operator: address,
    }

    struct EscrowCanceled has copy, drop {
        escrow_id: 0x2::object::ID,
    }

    struct EscrowFulfilled has copy, drop {
        escrow_id: 0x2::object::ID,
    }

    public(friend) fun add_supporting_coin_type(arg0: &mut Listings, arg1: 0x1::string::String) {
        0x2::vec_set::insert<0x1::string::String>(&mut arg0.supporting_coin_types, arg1);
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u256) * (arg1 as u256) / 10000) as u64)
    }

    public entry fun cancel_escrow<T0>(arg0: &mut Listings, arg1: Escrow<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fulfilled == false, 5);
        assert!(arg1.operator == 0x2::tx_context::sender(arg2), 10);
        let Escrow {
            id                       : v0,
            listing                  : v1,
            bid                      : v2,
            operator                 : _,
            payment                  : v4,
            fulfilled                : _,
            fee_recipient            : _,
            fee_amount               : _,
            buyer_warranty           : v8,
            warranty_price_recipient : _,
        } = arg1;
        let v10 = v8;
        let v11 = v4;
        let v12 = v2;
        let v13 = v1;
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, 0x2::object::id<Listing>(&v13), v13);
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v11)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v11), v12.buyer);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v11);
        let Bid {
            id         : v14,
            buyer      : _,
            price      : _,
            listing_id : _,
        } = v12;
        0x2::object::delete(v14);
        0x2::object::delete(v0);
        if (0x1::option::is_some<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::Warranty>(&v10)) {
            0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::delete(0x1::option::extract<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::Warranty>(&mut v10));
        };
        0x1::option::destroy_none<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::Warranty>(v10);
        let v18 = EscrowCanceled{escrow_id: 0x2::object::id<Escrow<T0>>(&arg1)};
        0x2::event::emit<EscrowCanceled>(v18);
    }

    public entry fun cancel_listing(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg1).seller == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let Listing {
            id             : v1,
            seller         : _,
            coin_type_name : _,
            min_price      : _,
            item           : v5,
        } = v0;
        let v6 = v5;
        let v7 = 0x1::option::extract<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&mut v6);
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(v7, 0x2::tx_context::sender(arg2));
        0x1::option::destroy_none<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(v6);
        let v8 = ListingCanceled{
            listing_id : 0x2::object::id<Listing>(&v0),
            seller     : 0x2::tx_context::sender(arg2),
            item_id    : 0x2::object::id<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&v7),
        };
        0x2::event::emit<ListingCanceled>(v8);
    }

    fun check_coin_type_match<T0>(arg0: 0x1::string::String) {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        assert!(arg0 == v0, 2);
    }

    public entry fun create_escrow_review<T0>(arg0: &mut Escrow<T0>, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 5, 7);
        assert!(0x1::string::length(&arg2) > 0, 8);
        assert!(arg0.listing.seller == 0x2::tx_context::sender(arg3) || arg0.bid.buyer == 0x2::tx_context::sender(arg3), 6);
        assert!(arg0.fulfilled == true, 9);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = if (arg0.listing.seller == v0) {
            0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::review::review_side_seller()
        } else {
            0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::review::review_side_buyer()
        };
        let v3 = 0x1::option::borrow<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&arg0.listing.item);
        0x2::dynamic_field::add<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::review::ReviewKey, 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::review::Review>(&mut arg0.id, v2, 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::review::create_review(v0, 0x2::object::id<Escrow<T0>>(arg0), v1, 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::get_asset_id(v3), 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::get_asset_type(v3), 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::get_asset_group_id(v3), arg1, arg2, arg3));
    }

    public entry fun fulfill_escrow<T0>(arg0: &mut Escrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fulfilled == false, 5);
        assert!(arg0.operator == 0x2::tx_context::sender(arg2), 10);
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg0.payment)) {
            let v0 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0.payment);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, arg0.fee_amount, arg2), arg0.fee_recipient);
            if (0x1::option::is_some<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::Warranty>(&arg0.buyer_warranty)) {
                let v1 = 0x1::option::extract<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::Warranty>(&mut arg0.buyer_warranty);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::price(&v1), arg2), arg0.warranty_price_recipient);
                0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::transfer_to_beneficiary(v1, 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::activate_warranty(&mut v1, arg1));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.listing.seller);
        };
        let v2 = EscrowFulfilled{escrow_id: 0x2::object::id<Escrow<T0>>(arg0)};
        0x2::event::emit<EscrowFulfilled>(v2);
        arg0.fulfilled = true;
    }

    fun init(arg0: MULTISIG_ESCROW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MULTISIG_ESCROW>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = Listings{
            id                       : 0x2::object::new(arg1),
            signer_public_key        : b"",
            fee_recipient            : 0x2::tx_context::sender(arg1),
            fee_rate                 : 0,
            warranty_price_recipient : 0x2::tx_context::sender(arg1),
            supporting_coin_types    : 0x2::vec_set::empty<0x1::string::String>(),
        };
        0x2::transfer::public_share_object<Listings>(v0);
    }

    public entry fun list(arg0: &mut Listings, arg1: 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg0.supporting_coin_types, &arg3), 2);
        let v0 = Listing{
            id             : 0x2::object::new(arg4),
            seller         : 0x2::tx_context::sender(arg4),
            coin_type_name : arg3,
            min_price      : arg2,
            item           : 0x1::option::some<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(arg1),
        };
        let v1 = 0x2::object::id<Listing>(&v0);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v1, v0);
        let v2 = ListingCreated{
            listing_id     : v1,
            seller         : 0x2::tx_context::sender(arg4),
            coin_type_name : arg3,
            min_price      : arg2,
            item_id        : 0x2::object::id<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&arg1),
        };
        0x2::event::emit<ListingCreated>(v2);
    }

    public entry fun new_escrow<T0>(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg1);
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x1::option::none<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::Warranty>();
        if (0x1::vector::length<vector<u8>>(&arg4) > 0) {
            0x1::option::fill<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::Warranty>(&mut v3, 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::new_warranty(v2, arg4, arg0.signer_public_key, arg5));
        };
        let v4 = v0.coin_type_name;
        let v5 = v0.min_price;
        check_coin_type_match<T0>(v4);
        let v6 = if (0x1::option::is_some<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::Warranty>(&v3)) {
            0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::price(0x1::option::borrow<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::Warranty>(&v3))
        } else {
            0
        };
        assert!(0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg3)) == v5 + v6, 3);
        let v7 = Bid{
            id         : 0x2::object::new(arg5),
            buyer      : 0x2::tx_context::sender(arg5),
            price      : v5,
            listing_id : arg1,
        };
        let v8 = Escrow<T0>{
            id                       : v1,
            listing                  : 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1),
            bid                      : v7,
            operator                 : arg2,
            payment                  : 0x1::option::some<0x2::coin::Coin<T0>>(arg3),
            fulfilled                : false,
            fee_recipient            : arg0.fee_recipient,
            fee_amount               : calculate_fee(v5, arg0.fee_rate),
            buyer_warranty           : v3,
            warranty_price_recipient : arg0.warranty_price_recipient,
        };
        0x2::transfer::public_share_object<Escrow<T0>>(v8);
        let v9 = EscrowCreated{
            escrow_id      : v2,
            listing_id     : arg1,
            bid_id         : 0x2::object::id<Bid>(&v7),
            buyer_address  : 0x2::tx_context::sender(arg5),
            coin_type_name : v4,
            price          : v5,
            operator       : arg2,
        };
        0x2::event::emit<EscrowCreated>(v9);
    }

    public(friend) fun remove_supporting_coin_type(arg0: &mut Listings, arg1: 0x1::string::String) {
        0x2::vec_set::remove<0x1::string::String>(&mut arg0.supporting_coin_types, &arg1);
    }

    public(friend) fun set_fee_rate(arg0: &mut Listings, arg1: u64) {
        assert!(arg1 <= 10000, 13906834814293508095);
        arg0.fee_rate = arg1;
    }

    public(friend) fun set_fee_recipient(arg0: &mut Listings, arg1: address) {
        arg0.fee_recipient = arg1;
    }

    public(friend) fun set_signer_public_key(arg0: &mut Listings, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906834749868998655);
        arg0.signer_public_key = arg1;
    }

    public(friend) fun set_warranty_price_recipient(arg0: &mut Listings, arg1: address) {
        arg0.warranty_price_recipient = arg1;
    }

    // decompiled from Move bytecode v6
}

