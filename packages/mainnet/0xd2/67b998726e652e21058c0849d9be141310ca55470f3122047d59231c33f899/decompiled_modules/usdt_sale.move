module 0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::usdt_sale {
    struct Listing has key {
        id: 0x2::object::UID,
        seller: address,
        price_raw: u64,
        nft_id: 0x2::object::ID,
        nft: 0x1::option::Option<0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::collection::NFT>,
    }

    struct Listed has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        price_raw: u64,
    }

    struct Purchased has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        paid_raw: u64,
    }

    struct Cancelled has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
    }

    fun assert_usdt_type<T0>() {
        assert!(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()) == 0x1::ascii::string(b"c060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN"), 0);
    }

    public fun available(arg0: &Listing) : bool {
        0x1::option::is_some<0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::collection::NFT>(&arg0.nft)
    }

    public fun buy<T0>(arg0: &mut Listing, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_usdt_type<T0>();
        buy_impl<T0>(arg0, arg1, arg2);
    }

    fun buy_impl<T0>(arg0: &mut Listing, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::collection::NFT>(&arg0.nft), 2);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.price_raw, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.seller);
        0x2::transfer::public_transfer<0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::collection::NFT>(0x1::option::extract<0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::collection::NFT>(&mut arg0.nft), v0);
        let v1 = Purchased{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : arg0.nft_id,
            seller     : arg0.seller,
            buyer      : v0,
            paid_raw   : arg0.price_raw,
        };
        0x2::event::emit<Purchased>(v1);
    }

    public fun cancel(arg0: &mut Listing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 3);
        assert!(0x1::option::is_some<0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::collection::NFT>(&arg0.nft), 2);
        0x2::transfer::public_transfer<0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::collection::NFT>(0x1::option::extract<0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::collection::NFT>(&mut arg0.nft), arg0.seller);
        let v0 = Cancelled{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : arg0.nft_id,
            seller     : arg0.seller,
        };
        0x2::event::emit<Cancelled>(v0);
    }

    public fun list(arg0: 0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::collection::NFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 4);
        let v0 = 0x2::object::id<0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::collection::NFT>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = Listing{
            id        : 0x2::object::new(arg2),
            seller    : v1,
            price_raw : arg1,
            nft_id    : v0,
            nft       : 0x1::option::some<0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::collection::NFT>(arg0),
        };
        let v3 = Listed{
            listing_id : 0x2::object::id<Listing>(&v2),
            nft_id     : v0,
            seller     : v1,
            price_raw  : arg1,
        };
        0x2::event::emit<Listed>(v3);
        0x2::transfer::share_object<Listing>(v2);
    }

    public fun price_raw(arg0: &Listing) : u64 {
        arg0.price_raw
    }

    public fun seller(arg0: &Listing) : address {
        arg0.seller
    }

    // decompiled from Move bytecode v7
}

