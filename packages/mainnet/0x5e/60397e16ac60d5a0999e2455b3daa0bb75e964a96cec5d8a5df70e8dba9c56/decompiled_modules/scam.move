module 0x5e60397e16ac60d5a0999e2455b3daa0bb75e964a96cec5d8a5df70e8dba9c56::scam {
    struct SCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAM>(arg0, 6, b"SCAM", b"Scamsui", x"497427732061207363616d202c206265206361726566756c202c20492077696c6c20727567200a4e6f206c696e6b73202c20626563617573652069742773207363616d20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047145_347ed72ab2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

