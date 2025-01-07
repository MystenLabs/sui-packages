module 0x78f38cd7d5af9f80bf1f8ddc5ac8beeed1b10a28abfc392c4b57e8723a04426b::bshark {
    struct BSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHARK>(arg0, 9, b"BSHARK", b"Baby Shark", x"4261627920536861726b20546f6b656e202842534841524b292069732061206d656d652063727970746f63757272656e6379206f6e205375692c20696e7370697265642062792074686520766972616c20224261627920536861726b2220736f6e672077697468206f7665722031332062696c6c696f6e2076696577732e2057697468206120737570706c79206f662031332062696c6c696f6e20746f6b656e732c2042534841524b20626c656e64732063756c7475726520616e6420626c6f636b636861696e20746563682c206f66666572696e6720446546692c204e46542c20616e6420636f6d6d756e697479206170706c69636174696f6e732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8fe79b8-d665-49a8-9c4c-a4979d5ea530.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

