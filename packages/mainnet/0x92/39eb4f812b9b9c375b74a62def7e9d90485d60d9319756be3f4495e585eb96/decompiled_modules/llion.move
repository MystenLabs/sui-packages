module 0x9239eb4f812b9b9c375b74a62def7e9d90485d60d9319756be3f4495e585eb96::llion {
    struct LLION has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLION>(arg0, 9, b"LLION", b"LunaLion", x"4c756e614c696f6e206973206d6f7265207468616e2061206d656d6520636f696ee280946974e28099732061206d6f76656d656e7420626c656e64696e67207468652066756e206f66206d656d657320776974682074686520706f74656e7469616c206f662063727970746f2e20497420656d706f7765727320657665727920686f6c64657220746f2062652070617274206f66206120636f6d6d756e6974792d64726976656e207265766f6c7574696f6e2c207472616e73666f726d696e6720746865206f7264696e61727920696e746f20736f6d657468696e672065787472616f7264696e617279207769746820657665727920737465702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5def0d05-c12c-4eb7-ac5a-40e40c4819ce-1000086508.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLION>>(v1);
    }

    // decompiled from Move bytecode v6
}

