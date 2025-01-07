module 0x90d29e516aabc026a2c515053c6b3f186a3e9df33e645cd20894a50ba571c92f::pk {
    struct PK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PK>(arg0, 9, b"PK", b"Piikaa", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<PK>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PK>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PK>>(v1);
    }

    // decompiled from Move bytecode v6
}

