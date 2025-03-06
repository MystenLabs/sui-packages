module 0xb1e7e037cdc284e27a593f5dc909aa01a39a60b6ae8610acb79b304fe0aa6413::raven {
    struct RAVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAVEN>(arg0, 6, b"RAVEN", b"SUI RAVEN", b"RAVEN ON SUI MASCOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_17_03_24_36_2_9e40e59165.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

