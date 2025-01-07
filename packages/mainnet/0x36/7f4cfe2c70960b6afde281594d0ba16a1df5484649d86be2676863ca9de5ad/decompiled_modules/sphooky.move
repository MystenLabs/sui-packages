module 0x367f4cfe2c70960b6afde281594d0ba16a1df5484649d86be2676863ca9de5ad::sphooky {
    struct SPHOOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPHOOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPHOOKY>(arg0, 6, b"SPHOOKY", b"Sphooky on Sui", x"5370686f6f6b79210a0a225370686f6f6b792220697320612066756e2c2048616c6c6f7765656e2d696e73706972656420746f6b656e0a74686174206164647320612064617368206f662067686f73746c7920636861726d20746f207468650a626c6f636b636861696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960406637.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPHOOKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPHOOKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

