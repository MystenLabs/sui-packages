module 0xca4dd21fe1a5620f4b4828937d5d4f2d860b655909f78a98ea369d13fcd5214::nemo {
    struct NEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMO>(arg0, 6, b"Nemo", b"Clown Fish on Sui", b"Early buyers will become millionaires .... !!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Dogs_e59f3182fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

