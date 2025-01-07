module 0x74a3e7094264e87356e2d5ae27f05bd94618f2cbcc6ec135d8ca014319caab03::catmeme {
    struct CATMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATMEME>(arg0, 6, b"CATMEME", b"CUTECAT", b"Cat is cute <3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.hydropump.xyz/logo/01JESZF4QM4PTXWZ7M9W17QT7G/01JFBWFA1ZHGJ6ECAHV54H6PM2")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATMEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

