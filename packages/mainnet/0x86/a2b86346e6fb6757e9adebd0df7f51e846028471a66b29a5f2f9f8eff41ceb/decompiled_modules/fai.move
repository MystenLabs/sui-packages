module 0x86a2b86346e6fb6757e9adebd0df7f51e846028471a66b29a5f2f9f8eff41ceb::fai {
    struct FAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAI>(arg0, 6, b"FAI", b"FartAI", b"FartAI is AI future project on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735759235111.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

