module 0xfdb846bb159095e1492d9fbe26931a423dc7d85da9868bf5e63e968491a4b0ed::meowlisa {
    struct MEOWLISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWLISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWLISA>(arg0, 6, b"Meowlisa", b"Meowlisa Cat", b"just Meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsfsf_88922f142b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWLISA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWLISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

