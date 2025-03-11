module 0x6965252f470b18ebd665f3b2f8c20332ba46e43dd92a0ee6c18eba8494372f8f::xscoin {
    struct XSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::option::none<0x2::url::Url>();
        let (v0, v1) = 0x2::coin::create_currency<XSCOIN>(arg0, 8, b"XSCOIN", b"XSCOIN", b"this is xsCOIn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/200202346?s=400&u=0bf2998d9aa3fbc7db0ef75b0ce17540049dddb1&v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun myburn(arg0: &mut 0x2::coin::TreasuryCap<XSCOIN>, arg1: 0x2::coin::Coin<XSCOIN>) {
        0x2::coin::burn<XSCOIN>(arg0, arg1);
    }

    public entry fun mymint(arg0: &mut 0x2::coin::TreasuryCap<XSCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XSCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

