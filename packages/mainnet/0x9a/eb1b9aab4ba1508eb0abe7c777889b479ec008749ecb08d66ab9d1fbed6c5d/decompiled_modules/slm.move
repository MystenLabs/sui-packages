module 0x9aeb1b9aab4ba1508eb0abe7c777889b479ec008749ecb08d66ab9d1fbed6c5d::slm {
    struct SLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLM>(arg0, 6, b"SLM", b"Small Language Model", b"Large Language Model Now Small Language Model Just Fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736408745293.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

