module 0xa201b3197652c3cffc9e8fd70f760e25d0d3e095a0299989eeed2263d7206502::xx {
    struct XX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XX>(arg0, 6, b"XX", b"Chromosome", b"From double helix to double gains. Join the $XX revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735608631773.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

