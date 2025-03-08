module 0x8454502551f3f36e05f7a36191f836b3c9638f1a112364ae3e8a4a6c974cc2d9::genz {
    struct GENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENZ>(arg0, 9, b"GENZ", b"GEN-Z", x"47454e2d5a204d656d6520436f696e3a2041206e6578742d67656e2063727970746f20626c656e64696e6720626c6f636b636861696e20616e6420696e7465726e65742063756c747572652e2049742073796d626f6c697a657320636f6d6d756e6974792c207472656e64732c20616e642066696e616e6369616c2066726565646f6de280946e6f74206a757374206120636f696e2c206275742061206d6f76656d656e7420666f72207468652066757475726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ada5cea3-d99f-4717-bf05-d34d032a11b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

