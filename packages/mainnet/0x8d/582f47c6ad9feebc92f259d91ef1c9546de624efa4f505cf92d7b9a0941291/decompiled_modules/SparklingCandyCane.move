module 0x8d582f47c6ad9feebc92f259d91ef1c9546de624efa4f505cf92d7b9a0941291::SparklingCandyCane {
    struct SPARKLINGCANDYCANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARKLINGCANDYCANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARKLINGCANDYCANE>(arg0, 0, b"COS", b"Sparkling Candy Cane", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Hand_Item_Sparkling_Candy_Cane.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPARKLINGCANDYCANE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARKLINGCANDYCANE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

