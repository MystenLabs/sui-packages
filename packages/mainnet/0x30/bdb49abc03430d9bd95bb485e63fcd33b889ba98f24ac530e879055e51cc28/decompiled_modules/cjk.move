module 0x30bdb49abc03430d9bd95bb485e63fcd33b889ba98f24ac530e879055e51cc28::cjk {
    struct CJK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CJK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CJK>(arg0, 6, b"CJK", b"CHARLIE JAMES KIRK", b"A celebration of open dialog and discussion. In memory of a brave peaceful example", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifuen77tfsabteqgdwql7igddky3cdzjgrxof4svgp5nvdxynfc6a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CJK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CJK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

