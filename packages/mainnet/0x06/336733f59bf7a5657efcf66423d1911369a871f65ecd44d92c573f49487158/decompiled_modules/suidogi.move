module 0x6336733f59bf7a5657efcf66423d1911369a871f65ecd44d92c573f49487158::suidogi {
    struct SUIDOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGI>(arg0, 6, b"Suidogi", b"Suidogicoin", b"a a a a dogi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/0_3_1_348b416214.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

