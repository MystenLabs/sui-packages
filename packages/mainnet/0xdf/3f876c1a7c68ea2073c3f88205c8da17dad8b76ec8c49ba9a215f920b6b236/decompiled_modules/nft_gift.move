module 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::nft_gift {
    struct ItemKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CardKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NftGift<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        creator: address,
        item_id: 0x2::object::ID,
        expires_ms: u64,
        flags: u8,
        message: 0x1::string::String,
        claimer: 0x1::option::Option<address>,
        active: bool,
    }

    struct NftGiftCreated has copy, drop {
        gift_id: 0x2::object::ID,
        creator: address,
        item_id: 0x2::object::ID,
        item_type: 0x1::ascii::String,
        flags: u8,
    }

    struct NftGiftClaimed has copy, drop {
        gift_id: 0x2::object::ID,
        claimer: address,
        item_id: 0x2::object::ID,
    }

    struct NftGiftReclaimed has copy, drop {
        gift_id: 0x2::object::ID,
        creator: address,
        item_id: 0x2::object::ID,
    }

    public fun card<T0: store + key>(arg0: &NftGift<T0>) : 0x1::string::String {
        let v0 = CardKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CardKey>(&arg0.id, v0)) {
            let v2 = CardKey{dummy_field: false};
            *0x2::dynamic_field::borrow<CardKey, 0x1::string::String>(&arg0.id, v2)
        } else {
            0x1::string::utf8(b"")
        }
    }

    entry fun claim<T0: store + key>(arg0: &mut NftGift<T0>, arg1: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.flags == 0, 7);
        do_claim<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun claim_with_ticket<T0: store + key>(arg0: &mut NftGift<T0>, arg1: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::verify_ticket(arg2, 0x2::object::id<NftGift<T0>>(arg0), 0x2::tx_context::sender(arg6), arg3, arg4, 0x2::clock::timestamp_ms(arg5)), 8);
        do_claim<T0>(arg0, arg1, arg5, arg6);
    }

    public fun claimer<T0: store + key>(arg0: &NftGift<T0>) : 0x1::option::Option<address> {
        arg0.claimer
    }

    public fun create<T0: store + key>(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: T0, arg2: u64, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::assert_version(arg0);
        assert!(arg3 <= 1 | 2 | 4, 10);
        assert!(0x1::string::length(&arg4) <= 500, 19);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = NftGift<T0>{
            id         : 0x2::object::new(arg6),
            creator    : 0x2::tx_context::sender(arg6),
            item_id    : v0,
            expires_ms : arg2,
            flags      : arg3,
            message    : arg4,
            claimer    : 0x1::option::none<address>(),
            active     : true,
        };
        if (0x1::string::length(&arg5) > 0) {
            assert!(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::is_blob_id(&arg5), 14);
            let v2 = CardKey{dummy_field: false};
            0x2::dynamic_field::add<CardKey, 0x1::string::String>(&mut v1.id, v2, arg5);
        };
        let v3 = ItemKey{dummy_field: false};
        0x2::dynamic_object_field::add<ItemKey, T0>(&mut v1.id, v3, arg1);
        let v4 = 0x2::object::id<NftGift<T0>>(&v1);
        let v5 = NftGiftCreated{
            gift_id   : v4,
            creator   : v1.creator,
            item_id   : v0,
            item_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            flags     : arg3,
        };
        0x2::event::emit<NftGiftCreated>(v5);
        0x2::transfer::share_object<NftGift<T0>>(v1);
        v4
    }

    public fun creator<T0: store + key>(arg0: &NftGift<T0>) : address {
        arg0.creator
    }

    fun do_claim<T0: store + key>(arg0: &mut NftGift<T0>, arg1: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::assert_version(arg1);
        assert!(arg0.active, 2);
        assert!(arg0.expires_ms == 0 || 0x2::clock::timestamp_ms(arg2) < arg0.expires_ms, 3);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = ItemKey{dummy_field: false};
        arg0.active = false;
        arg0.claimer = 0x1::option::some<address>(v0);
        let v2 = NftGiftClaimed{
            gift_id : 0x2::object::id<NftGift<T0>>(arg0),
            claimer : v0,
            item_id : arg0.item_id,
        };
        0x2::event::emit<NftGiftClaimed>(v2);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<ItemKey, T0>(&mut arg0.id, v1), v0);
    }

    public fun is_active<T0: store + key>(arg0: &NftGift<T0>) : bool {
        arg0.active
    }

    public fun item_id<T0: store + key>(arg0: &NftGift<T0>) : 0x2::object::ID {
        arg0.item_id
    }

    entry fun reclaim<T0: store + key>(arg0: &mut NftGift<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 6);
        assert!(arg0.active, 2);
        let v0 = ItemKey{dummy_field: false};
        arg0.active = false;
        let v1 = NftGiftReclaimed{
            gift_id : 0x2::object::id<NftGift<T0>>(arg0),
            creator : arg0.creator,
            item_id : arg0.item_id,
        };
        0x2::event::emit<NftGiftReclaimed>(v1);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<ItemKey, T0>(&mut arg0.id, v0), arg0.creator);
    }

    // decompiled from Move bytecode v7
}

