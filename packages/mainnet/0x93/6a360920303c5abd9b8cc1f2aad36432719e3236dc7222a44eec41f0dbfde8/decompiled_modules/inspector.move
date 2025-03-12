module 0x936a360920303c5abd9b8cc1f2aad36432719e3236dc7222a44eec41f0dbfde8::inspector {
    struct Event<T0: copy + drop> has copy, drop {
        val: T0,
    }

    struct INSPECTOR has drop {
        dummy_field: bool,
    }

    struct Holder<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{val: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    fun init(arg0: INSPECTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSPECTOR>(arg0, 18, b"custom symbol", b"custom name", b"custom description", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = Holder<INSPECTOR>{id: 0x2::object::new(arg1)};
        0x2::dynamic_object_field::add<u8, 0x2::coin::TreasuryCap<INSPECTOR>>(&mut v2.id, 0, v0);
        0x2::dynamic_object_field::add<u8, 0x2::coin::CoinMetadata<INSPECTOR>>(&mut v2.id, 1, v1);
        0x2::transfer::public_transfer<Holder<INSPECTOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun unwrap<T0>(arg0: Holder<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Holder { id: v0 } = arg0;
        let v1 = 0x2::dynamic_object_field::remove<u8, 0x2::coin::TreasuryCap<T0>>(&mut v0, 0);
        let v2 = 0x2::dynamic_object_field::remove<u8, 0x2::coin::CoinMetadata<T0>>(&mut v0, 1);
        emit<u64>(0x2::coin::total_supply<T0>(&v1));
        emit<u8>(0x2::coin::get_decimals<T0>(&v2));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

