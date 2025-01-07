module 0xc7d3fe3ef90c7c498e64483755de055038e413ccd7f045786fd9017106cb8a2f::sporeon {
    struct SPOREON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOREON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOREON>(arg0, 6, b"SPOREON", b"SUIPOREON", b"SUIPOREON is the first reserve currency riding the waves of the #Suinami ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x84d155fb70aebcc1391bf497d8fc139154be745765dfec57faef4704f4112c79_vaporeon_vaporeon_dba60ed207.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOREON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOREON>>(v1);
    }

    // decompiled from Move bytecode v6
}

