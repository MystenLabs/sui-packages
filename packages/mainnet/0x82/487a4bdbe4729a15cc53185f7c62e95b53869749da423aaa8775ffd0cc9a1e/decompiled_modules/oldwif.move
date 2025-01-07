module 0x82487a4bdbe4729a15cc53185f7c62e95b53869749da423aaa8775ffd0cc9a1e::oldwif {
    struct OLDWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLDWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLDWIF>(arg0, 6, b"OLDWIF", b"The First Dog Wif Hat", x"56696e7461676520646f672070686f746f206170706172656e746c7920646174656420313839342066726f6d20426f6e7175652026204b696e6465726d616e6e2070686f746f677261706865727320696e2048616d627572672c204765726d616e792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dog_in_top_hat_90d1de27d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLDWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLDWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

