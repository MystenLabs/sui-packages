module 0x1321690067eaae0b48015bb31561fb429a4f42c728bb5d7b01add1e36df49e46::homie {
    struct HOMIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMIE>(arg0, 9, b"HOMIE", b"homie", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://picsum.photos/200/300")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HOMIE>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

