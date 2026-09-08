module 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids {
    struct CollBids has drop {
        dummy_field: bool,
    }

    struct Criterion has copy, drop, store {
        key: 0x1::string::String,
        op: u8,
        values: vector<0x1::string::String>,
        min: u64,
        max: u64,
    }

    struct Attr has copy, drop, store {
        key: 0x1::string::String,
        text: 0x1::string::String,
        num: 0x1::option::Option<u64>,
    }

    struct Attrs<phantom T0> has drop {
        entries: vector<Attr>,
    }

    struct CollectionBid<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        bidder: address,
        bidder_kiosk: 0x1::option::Option<0x2::object::ID>,
        escrow: 0x2::coin::Coin<T1>,
        expires_ms: u64,
        criteria: vector<Criterion>,
    }

    struct CollectionBidPlaced has copy, drop {
        bid_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
        bidder: address,
        bidder_kiosk: 0x1::option::Option<0x2::object::ID>,
        amount: u64,
        expires_ms: u64,
        criteria: vector<Criterion>,
    }

    struct CollectionBidCancelled has copy, drop {
        bid_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
        bidder: address,
        amount: u64,
    }

    struct CollectionBidAccepted has copy, drop {
        bid_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
        item_id: 0x2::object::ID,
        bidder: address,
        seller: address,
        amount: u64,
    }

    public fun accept<T0: store + key, T1>(arg0: CollectionBid<T0, T1>, arg1: T0, arg2: Attrs<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expires_ms, 3);
        assert!(satisfies<T0>(&arg0.criteria, &arg2), 9);
        let (v0, v1) = settle<T0, T1>(arg0, 0x2::object::id<T0>(&arg1), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<T0>(arg1, v0);
    }

    public fun accept_locked<T0: store + key, T1>(arg0: CollectionBid<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: Attrs<T0>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::clock::timestamp_ms(arg7) < arg0.expires_ms, 3);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.bidder_kiosk), 8);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg5) == *0x1::option::borrow<0x2::object::ID>(&arg0.bidder_kiosk), 7);
        assert!(satisfies<T0>(&arg0.criteria, &arg4), 9);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg8), 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v2 = CollBids{dummy_field: false};
        0x2::kiosk_extension::lock<CollBids, T0>(v2, arg5, v0, arg6);
        let (_, v4) = settle<T0, T1>(arg0, arg3, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg8));
        v1
    }

    public fun amount<T0, T1>(arg0: &CollectionBid<T0, T1>) : u64 {
        0x2::coin::value<T1>(&arg0.escrow)
    }

    public fun attr_count<T0>(arg0: &Attrs<T0>) : u64 {
        0x1::vector::length<Attr>(&arg0.entries)
    }

    public fun bidder<T0, T1>(arg0: &CollectionBid<T0, T1>) : address {
        arg0.bidder
    }

    public fun bidder_kiosk<T0, T1>(arg0: &CollectionBid<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.bidder_kiosk
    }

    public fun cancel<T0, T1>(arg0: CollectionBid<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.bidder || 0x2::clock::timestamp_ms(arg1) >= arg0.expires_ms, 1);
        let CollectionBid {
            id           : v0,
            bidder       : v1,
            bidder_kiosk : _,
            escrow       : v3,
            expires_ms   : _,
            criteria     : _,
        } = arg0;
        let v6 = v3;
        let v7 = v0;
        let v8 = CollectionBidCancelled{
            bid_id    : 0x2::object::uid_to_inner(&v7),
            item_type : 0x1::type_name::with_defining_ids<T0>(),
            bidder    : v1,
            amount    : 0x2::coin::value<T1>(&v6),
        };
        0x2::event::emit<CollectionBidCancelled>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, v1);
        0x2::object::delete(v7);
    }

    public fun criteria<T0, T1>(arg0: &CollectionBid<T0, T1>) : &vector<Criterion> {
        &arg0.criteria
    }

    public fun criterion(arg0: vector<u8>, arg1: u8, arg2: vector<vector<u8>>, arg3: u64, arg4: u64) : Criterion {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(lower(*0x1::vector::borrow<vector<u8>>(&arg2, v1))));
            v1 = v1 + 1;
        };
        let v2 = Criterion{
            key    : 0x1::string::utf8(lower(arg0)),
            op     : arg1,
            values : v0,
            min    : arg3,
            max    : arg4,
        };
        assert!(valid(&v2), 10);
        v2
    }

    public fun expires_ms<T0, T1>(arg0: &CollectionBid<T0, T1>) : u64 {
        arg0.expires_ms
    }

    fun holds(arg0: &Criterion, arg1: &vector<Attr>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Attr>(arg1)) {
            let v1 = 0x1::vector::borrow<Attr>(arg1, v0);
            if (v1.key == arg0.key) {
                if (arg0.op == 1) {
                    return 0x1::vector::contains<0x1::string::String>(&arg0.values, &v1.text)
                };
                if (arg0.op == 2) {
                    if (0x1::option::is_none<u64>(&v1.num)) {
                        return false
                    };
                    let v2 = *0x1::option::borrow<u64>(&v1.num);
                    return v2 >= arg0.min && v2 <= arg0.max
                };
                return false
            };
            v0 = v0 + 1;
        };
        false
    }

    fun lower(arg0: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            if (v2 >= 65 && v2 <= 90) {
                0x1::vector::push_back<u8>(&mut v0, v2 + 32);
            } else {
                0x1::vector::push_back<u8>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun matches<T0, T1>(arg0: &CollectionBid<T0, T1>, arg1: &Attrs<T0>) : bool {
        satisfies<T0>(&arg0.criteria, arg1)
    }

    public(friend) fun new_attrs<T0>() : Attrs<T0> {
        Attrs<T0>{entries: 0x1::vector::empty<Attr>()}
    }

    fun new_bid<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<Criterion>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : CollectionBid<T0, T1> {
        assert!(0x2::coin::value<T1>(&arg0) > 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 > v0 && arg3 <= v0 + 2592000000, 6);
        validate_all(&arg2);
        let v1 = CollectionBid<T0, T1>{
            id           : 0x2::object::new(arg5),
            bidder       : 0x2::tx_context::sender(arg5),
            bidder_kiosk : arg1,
            escrow       : arg0,
            expires_ms   : arg3,
            criteria     : arg2,
        };
        let v2 = CollectionBidPlaced{
            bid_id       : 0x2::object::id<CollectionBid<T0, T1>>(&v1),
            item_type    : 0x1::type_name::with_defining_ids<T0>(),
            bidder       : v1.bidder,
            bidder_kiosk : v1.bidder_kiosk,
            amount       : 0x2::coin::value<T1>(&v1.escrow),
            expires_ms   : arg3,
            criteria     : v1.criteria,
        };
        0x2::event::emit<CollectionBidPlaced>(v2);
        v1
    }

    fun parse_u64(arg0: &vector<u8>) : 0x1::option::Option<u64> {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0 || v0 > 19) {
            return 0x1::option::none<u64>()
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            if (v3 < 48 || v3 > 57) {
                return 0x1::option::none<u64>()
            };
            let v4 = v1 * 10;
            v1 = v4 + ((v3 - 48) as u64);
            v2 = v2 + 1;
        };
        0x1::option::some<u64>(v1)
    }

    public fun place<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: vector<Criterion>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<CollectionBid<T0, T1>>(new_bid<T0, T1>(arg0, 0x1::option::none<0x2::object::ID>(), arg1, arg2, arg3, arg4));
    }

    public fun place_locked<T0, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::coin::Coin<T1>, arg3: vector<Criterion>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (!0x2::kiosk_extension::is_installed<CollBids>(arg0)) {
            let v0 = CollBids{dummy_field: false};
            0x2::kiosk_extension::add<CollBids>(v0, arg0, arg1, 2, arg6);
        } else if (!0x2::kiosk_extension::is_enabled<CollBids>(arg0)) {
            0x2::kiosk_extension::enable<CollBids>(arg0, arg1);
        };
        0x2::transfer::share_object<CollectionBid<T0, T1>>(new_bid<T0, T1>(arg2, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg0)), arg3, arg4, arg5, arg6));
    }

    public(friend) fun push_coded<T0>(arg0: &mut Attrs<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) {
        let v0 = Attr{
            key  : 0x1::string::utf8(arg1),
            text : 0x1::string::utf8(lower(arg2)),
            num  : 0x1::option::some<u64>(arg3),
        };
        0x1::vector::push_back<Attr>(&mut arg0.entries, v0);
    }

    public(friend) fun push_num<T0>(arg0: &mut Attrs<T0>, arg1: vector<u8>, arg2: u64) {
        let v0 = Attr{
            key  : 0x1::string::utf8(arg1),
            text : 0x1::string::utf8(to_decimal(arg2)),
            num  : 0x1::option::some<u64>(arg2),
        };
        0x1::vector::push_back<Attr>(&mut arg0.entries, v0);
    }

    public(friend) fun push_text<T0>(arg0: &mut Attrs<T0>, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = lower(arg2);
        let v1 = Attr{
            key  : 0x1::string::utf8(lower(arg1)),
            text : 0x1::string::utf8(v0),
            num  : parse_u64(&v0),
        };
        0x1::vector::push_back<Attr>(&mut arg0.entries, v1);
    }

    public fun satisfies<T0>(arg0: &vector<Criterion>, arg1: &Attrs<T0>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Criterion>(arg0)) {
            if (!holds(0x1::vector::borrow<Criterion>(arg0, v0), &arg1.entries)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun settle<T0, T1>(arg0: CollectionBid<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : (address, 0x2::coin::Coin<T1>) {
        let CollectionBid {
            id           : v0,
            bidder       : v1,
            bidder_kiosk : _,
            escrow       : v3,
            expires_ms   : _,
            criteria     : _,
        } = arg0;
        let v6 = v3;
        let v7 = v0;
        let v8 = 0x2::coin::value<T1>(&v6);
        let v9 = v8 * 500 / 10000;
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v6, v9, arg2), @0x5077e43c411dec5ef5464ae9b337c2644d0300140b9caecad860a14fd7a22711);
        };
        let v10 = CollectionBidAccepted{
            bid_id    : 0x2::object::uid_to_inner(&v7),
            item_type : 0x1::type_name::with_defining_ids<T0>(),
            item_id   : arg1,
            bidder    : v1,
            seller    : 0x2::tx_context::sender(arg2),
            amount    : v8,
        };
        0x2::event::emit<CollectionBidAccepted>(v10);
        0x2::object::delete(v7);
        (v1, v6)
    }

    fun to_decimal(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        let v1 = b"";
        let v2 = 0x1::vector::length<u8>(&v0);
        while (v2 > 0) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2 - 1));
            v2 = v2 - 1;
        };
        v1
    }

    fun valid(arg0: &Criterion) : bool {
        if (0x1::string::length(&arg0.key) == 0) {
            return false
        };
        if (arg0.op == 1) {
            return 0x1::vector::length<0x1::string::String>(&arg0.values) > 0
        };
        if (arg0.op == 2) {
            return arg0.min <= arg0.max
        };
        false
    }

    fun validate_all(arg0: &vector<Criterion>) {
        assert!(0x1::vector::length<Criterion>(arg0) <= 8, 11);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Criterion>(arg0)) {
            assert!(valid(0x1::vector::borrow<Criterion>(arg0, v0)), 10);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

