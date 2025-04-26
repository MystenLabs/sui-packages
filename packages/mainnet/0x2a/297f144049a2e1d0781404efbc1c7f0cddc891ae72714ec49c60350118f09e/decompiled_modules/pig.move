module 0x2a297f144049a2e1d0781404efbc1c7f0cddc891ae72714ec49c60350118f09e::pig {
    struct PIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIG>(arg0, 9, b"PIG", b"PIGO", b"pig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/59dbc986ee478b428b412c020cb4eae3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

