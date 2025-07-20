module 0x9ecb744afaf6f671f86f39b05f8408a445cd141911dc22a604fa54ebba066ac1::mnt {
    struct MNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNT>(arg0, 6, b"MNT", b"Manatee", x"54686572652069732073696d706c79206e6f2062657474657220766962652e0a0a596f752061726520696e206120736561206f66206d6167696320616e6420746865206d616e6174656520636f6d657320746f206368696c6c2e0a0a506c616e732e2020426967206f6e65732e20200a0a5820636f6d696e670a0a5765627369746520636f6d696e670a0a4e66747320636f6d696e670a0a496d6d6163756c61746520766962657320636f6d696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiazu6nnxdwpbk7v3r5apb4mekoyglfbrhvticfyj5jna7pwcznkxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MNT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

