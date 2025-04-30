module 0x8cf44a73bef4c63dd2127e82a59a1fcb0d2bc708706e9e92dc08a32357b701e4::crhds {
    struct CRHDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRHDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRHDS>(arg0, 6, b"CRHDS", b"CrazyHeads", x"546865206368616f7320626567696e732e2e2e206f6e2d636861696e2e0a47657420726561647920746f20756e6c65617368207468652077696c646573742c206d6f737420756e66696c7465726564206d656d65636f696e20657870657269656e636520657665722064726f70706564206f6e205375692e4e6f206272616b65732c206e6f2066696c7465727320206a757374207075726520424153452d6c6576656c206d61646e657373206e6f77206c616e64696e67206f6e205375692e0a4275696c7420666f722074686520646567656e73204675656c6564206279206d656d657320506f776572656420627920537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_05_01_00_01_31_b6e009c1e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRHDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRHDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

