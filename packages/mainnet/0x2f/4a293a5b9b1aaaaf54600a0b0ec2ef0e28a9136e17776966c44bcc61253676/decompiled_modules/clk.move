module 0x2f4a293a5b9b1aaaaf54600a0b0ec2ef0e28a9136e17776966c44bcc61253676::clk {
    struct CLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLK>(arg0, 9, b"CLK", b"clocks", x"5469636b20746f2073756363657373207769746820436c6f636b73436f696e3a205468652070756e637475616c2063727970746f63757272656e63792074686174277320616c6c2061626f7574206d616b696e67206576657279207365636f6e6420636f756e742c2064656c69766572696e672074696d656c792070726f66697473207769746820636c6f636b776f726b20707265636973696f6e2120f09f95b0efb88ff09f92b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b60475e4-2d97-4e42-a010-297646245c68.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

