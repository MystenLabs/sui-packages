module 0x98cd30887743839b7f4a7427ed6bcb84dcba88ecd54acea8bc2ce39628e13b19::xllm {
    struct XLLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: XLLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XLLM>(arg0, 6, b"XLLM", b"Extra Large Language", b"Extra Large Language Model .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737769526682.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XLLM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XLLM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

