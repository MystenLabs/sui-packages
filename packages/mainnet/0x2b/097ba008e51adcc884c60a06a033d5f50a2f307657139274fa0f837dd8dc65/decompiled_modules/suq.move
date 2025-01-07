module 0x2b097ba008e51adcc884c60a06a033d5f50a2f307657139274fa0f837dd8dc65::suq {
    struct SUQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUQ>(arg0, 6, b"SUQ", b"Suiqrtle", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUQ>>(v1);
        0x2::coin::mint_and_transfer<SUQ>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUQ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

