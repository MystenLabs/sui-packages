module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::watrfall {
    struct WATRFALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATRFALL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATRFALL>>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::setup::setup<WATRFALL>(arg0, 0, b"WATRFALL", b"Watrfall Powered by Republic", b"Watrfall Powered by Republic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/XxAHeWW7g-ztxv1qnY1_JkUNIuPtHkjbEbYYJN7VWzo")), arg1));
    }

    // decompiled from Move bytecode v7
}

