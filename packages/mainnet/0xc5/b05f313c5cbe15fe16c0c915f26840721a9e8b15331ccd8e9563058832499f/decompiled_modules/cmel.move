module 0xc5b05f313c5cbe15fe16c0c915f26840721a9e8b15331ccd8e9563058832499f::cmel {
    struct CMEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMEL>(arg0, 6, b"CMEL", b"CATAMEL", b"The Ultimate Camel-cat Craze on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_20241216_215616_0000_9221feafc0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CMEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

