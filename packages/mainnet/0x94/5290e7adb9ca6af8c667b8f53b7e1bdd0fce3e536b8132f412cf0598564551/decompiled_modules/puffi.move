module 0x945290e7adb9ca6af8c667b8f53b7e1bdd0fce3e536b8132f412cf0598564551::puffi {
    struct PUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFI>(arg0, 6, b"Puffi", b"Puffi on Sui", x"61626f75740a0a0a50756666692069732074686520207075666665722066697368206f660a746865206d656d6520636f696e20776f726c642c0a6272696e67696e67207468652066756e20616e6420636861726d0a776974682069742e2049747320676f742074686520636f6f6c0a666163746f7220414e442020756e69717565207374796c652e0a4275696c74206f6e207468652053756920626c6f636b636861696e2c0a5075666669206973206865726520746f206d616b652077617665730a616e642070756d7020757020746865206d656d6520636f696e0a67616d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/puff_profile_415a4116c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

