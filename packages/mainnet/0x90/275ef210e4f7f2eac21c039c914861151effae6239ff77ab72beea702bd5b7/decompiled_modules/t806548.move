module 0x90275ef210e4f7f2eac21c039c914861151effae6239ff77ab72beea702bd5b7::t806548 {
    struct T806548 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T806548, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T806548>(arg0, 9, b"T806548", b"Test 806548", b"Integration test token 2025-10-19T23:16:46.548Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T806548>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T806548>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

