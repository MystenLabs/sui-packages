module 0x298ca5c4217e46aa1a10977088333d05b68ea09a6f0c08b033fabd86c380e0b4::mbsa {
    struct MBSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBSA>(arg0, 6, b"MBSA", b"Make SUI Based Again!", b"lets do this !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MBSA_63b7919c37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

