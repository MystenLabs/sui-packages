module 0xb2b0b152c93aed42ec5fee5636893c09c99cc4700c57dfd1ffb42b5ea233778b::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"SUIVERSE", x"5375695665727365202d2020697320636f6e666964656e74207468617420627920666f637573696e67206f6e207574696c69747920616e642073656375726974792c206265636f6d652061206c656164696e6720616e64207472757374656420626c6f636b636861696e206e6574776f726b20666f7220746865207075626c69632e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_e71c148483.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

