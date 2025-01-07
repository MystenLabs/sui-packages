module 0xd13105f9c31c38e5ce41f98033d02af6a61e78c15d68d01ec3557dc2b3f2b61::mibs {
    struct MIBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIBS>(arg0, 6, b"MIBS", b"Men In Black SUIts", b"Men in Black SUIts are the ultimate alpha males making money on the SUI blockchain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9476_76751f86e5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

