module 0x63f7f972b0c4760e1044acc661de4f196ea45dd5df8499bf9cd0d51be9980f0::neko {
    struct NEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKO>(arg0, 6, b"NEKO", b"Sui Neko", x"4a757374206120244e454b4f2070757272696e67206f6e20245355492c20726561647920746f2065787072657373206974732061646f7261626c6520726f61720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_Lxns_Xsq_400x400_2cc949b2b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

