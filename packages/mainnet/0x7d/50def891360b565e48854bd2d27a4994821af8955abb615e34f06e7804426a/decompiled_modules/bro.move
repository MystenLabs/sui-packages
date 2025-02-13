module 0x7d50def891360b565e48854bd2d27a4994821af8955abb615e34f06e7804426a::bro {
    struct BRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRO>(arg0, 6, b"BRO", b"Broccoli", x"42726f63636f6c6920435a20436f6d657320486f6d6520746f205355492120f09f9a800a0a46726f6d20616e20756e6578706563746564206769667420746f2061206c6567656e6420696e2063727970746f2c2042726f63636f6c692074686520446f676720697320686572652120466173742c20666561726c6573732c20616e642066756c6c206f6620656e65726779e280946a757374206c696b65205355492c207468652066617374657374206e6574776f726b2e2057696c6c2074686520636f6d6d756e6974792074616b652042726f63636f6c6920746f20746865206d6f6f6e3f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739465947431.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

