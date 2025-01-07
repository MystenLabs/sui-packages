module 0xef18354775a87b6e00e6c73f7fa7a630926b43aeab47e5335c4ff1ad59c56614::wenking {
    struct WENKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: WENKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WENKING>(arg0, 6, b"WENKING", b"WEN KINH ON SUI", x"546865202457454e4b494e4720746f6b656e20697320616e20696e6e6f7661746976652063727970746f63757272656e6379206f7065726174696e67206f6e207468652053756920626c6f636b636861696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bff79bd65e63067782714cdde1df28d4_1317980f76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WENKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WENKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

