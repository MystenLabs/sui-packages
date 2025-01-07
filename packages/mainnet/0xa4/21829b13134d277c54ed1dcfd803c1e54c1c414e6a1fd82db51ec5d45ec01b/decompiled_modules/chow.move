module 0xa421829b13134d277c54ed1dcfd803c1e54c1c414e6a1fd82db51ec5d45ec01b::chow {
    struct CHOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOW>(arg0, 6, b"Chow", b"Chow chow", b"The original chow chow dog dedicated to cute chow chow breed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1002548751_a1eb545adb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

