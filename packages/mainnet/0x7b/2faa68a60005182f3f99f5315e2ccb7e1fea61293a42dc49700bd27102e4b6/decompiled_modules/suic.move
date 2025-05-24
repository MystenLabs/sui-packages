module 0x7b2faa68a60005182f3f99f5315e2ccb7e1fea61293a42dc49700bd27102e4b6::suic {
    struct SUIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIC>(arg0, 6, b"SUIC", b"SUI Classic", b"The commemorative meme token born from the aftermath of the Cetus hack (May 2025). Celebrating SUI's decisive action to implement measures for fund recovery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748065950658.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

