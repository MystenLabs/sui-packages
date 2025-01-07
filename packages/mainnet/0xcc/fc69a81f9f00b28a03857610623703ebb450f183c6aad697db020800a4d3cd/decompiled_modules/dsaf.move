module 0xccfc69a81f9f00b28a03857610623703ebb450f183c6aad697db020800a4d3cd::dsaf {
    struct DSAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSAF>(arg0, 9, b"DSAF", b"DSA", b"DASF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e1df94c-6855-4da0-84bb-ddc8b295243e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

