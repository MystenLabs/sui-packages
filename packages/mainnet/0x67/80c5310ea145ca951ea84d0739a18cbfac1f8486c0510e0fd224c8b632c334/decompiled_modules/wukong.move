module 0x6780c5310ea145ca951ea84d0739a18cbfac1f8486c0510e0fd224c8b632c334::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"WUkong", b"Wukong", x"57756b6f6e67206973206e6f74206a757374206120746f6b656e2c2062757420616c736f2061206c6567656e64617279206a6f75726e65792066726f6d204561737465726e206d7974686f6c6f67792e200a546865202457554b4f4e4720746f6b656e20696e746567726174657320746869732073706972697420696e746f2074686520626c6f636b636861696e20776f726c642c20676976696e672069747320686f6c6465727320612073796d626f6c6963206d65616e696e67206f6620666561726c6573736e6573732c20616476656e747572652c20616e64206578706c6f726174696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1729076043669_69fa36a84f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

