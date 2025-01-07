module 0xebac51e3e41338f675b1c4b627a5c1afb649cabc01a39b3af2fa3d57b1524dcc::mikumari {
    struct MIKUMARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKUMARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKUMARI>(arg0, 6, b"Mikumari", b"Amenomikumari", b"Japanese water goddess (SUI). As a god who distributes water, he was also the subject of prayers for rain, and those worshiped at water sources were also noted as mountain gods. It also came to be worshiped as the protector of the world and the god of child-bearing and safe childbirth. Keep God in your wallet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1529_55bfd41f58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKUMARI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKUMARI>>(v1);
    }

    // decompiled from Move bytecode v6
}

