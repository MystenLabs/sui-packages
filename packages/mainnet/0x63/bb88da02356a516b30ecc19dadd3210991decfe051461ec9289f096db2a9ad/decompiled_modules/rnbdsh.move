module 0x63bb88da02356a516b30ecc19dadd3210991decfe051461ec9289f096db2a9ad::rnbdsh {
    struct RNBDSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RNBDSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RNBDSH>(arg0, 9, b"RNBDSH", b"Rainbow Dash", b"pony in MLP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/71bc456e96a6f03629b95bb898ba4b73blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RNBDSH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RNBDSH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

