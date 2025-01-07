module 0x12a1f15cef1964a3a079581579a8c87e3347c8c0af37318eba8d0a4377ae7397::tree {
    struct TREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREE>(arg0, 9, b"TREE", b"the tree", x"477265656e20616e6420737461626c65206469676974616c2063757272656e63790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86f14aa6-60c6-4f5e-b3dc-7a3955aaa2de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

