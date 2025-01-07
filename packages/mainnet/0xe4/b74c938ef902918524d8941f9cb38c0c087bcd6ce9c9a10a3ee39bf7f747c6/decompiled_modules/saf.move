module 0xe4b74c938ef902918524d8941f9cb38c0c087bcd6ce9c9a10a3ee39bf7f747c6::saf {
    struct SAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAF>(arg0, 6, b"SAF", b"Sui Animal Farm", x"53756920416e696d616c204661726d2069732061206d656d6520636f696e2070726f6a656374207468617420636f6d62696e65732066756e2c20696e6e6f766174696f6e2c20616e64207574696c6974792c206372656174696e6720612076696272616e7420616e6420656e67616765642063727970746f20636f6d6d756e697479206f6e20746865202453554920626c6f636b636861696e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avt_1_2ba2eabaa7.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

