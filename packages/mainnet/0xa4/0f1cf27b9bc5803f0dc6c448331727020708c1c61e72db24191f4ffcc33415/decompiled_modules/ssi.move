module 0xa40f1cf27b9bc5803f0dc6c448331727020708c1c61e72db24191f4ffcc33415::ssi {
    struct SSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSI>(arg0, 6, b"SsI", b"Sui-shi", b"A decentralized meme token based on abundance ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/35378c28_e443_41a3_833a_c5b4181da11d_3d3d51c5b5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

