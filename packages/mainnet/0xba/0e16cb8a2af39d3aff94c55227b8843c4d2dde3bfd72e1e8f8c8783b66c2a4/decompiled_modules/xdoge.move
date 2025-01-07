module 0xba0e16cb8a2af39d3aff94c55227b8843c4d2dde3bfd72e1e8f8c8783b66c2a4::xdoge {
    struct XDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDOGE>(arg0, 6, b"XDOGE", b"Xen Doge", x"496e74726f647563696e672058656e20446f676520436f696e202858444f4745292020746865206d656469746174697665206d656d6520746f6b656e2074686174206272696e6773207468652063616c6d206f66207a656e20616e642074686520706c617966756c20737069726974206f66206f757220667572727920667269656e647320746f676574686572212057697468206576657279207472616e73616374696f6e2c20796f757265206e6f74206a75737420696e76657374696e673b20796f7572652066696e64696e6720796f757220666c6f77210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_BC_54_F30_0313_4509_8_E9_D_F8_ABB_52_B2_AFC_57ad0010e1.WEBP")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

