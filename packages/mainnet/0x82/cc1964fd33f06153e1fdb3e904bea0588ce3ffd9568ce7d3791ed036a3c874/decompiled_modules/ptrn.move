module 0x82cc1964fd33f06153e1fdb3e904bea0588ce3ffd9568ce7d3791ed036a3c874::ptrn {
    struct PTRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<PTRN>(arg0, b"PTRN", b"PatronCoin", x"506174726f6e436f696e20285054524e292069732061206d656d652d706f776572656420746f6b656e20696e73706972656420627920556b7261696e65e2809973206d6f73742062656c6f7665642073617070657220646f672c20506174726f6e20f09f90be2e20466173742c2062726176652c20616e64206c6f79616c20e28094206a757374206c696b6520697473206e616d6573616b6520e28094205054524e206973206120636f6d6d756e6974792d64726976656e20746f6b656e206275696c7420746f206272696e672066756e2c20756e6974792c20616e64206120626974206f6620626f6f6d20746f2074686520776f726c64206f662063727970746f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQB3cDkR4uZJeBQ9mhAu7KxjPnmTo9oRDgMhPbPpDesqz")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0076d1c9fc5f79ef3d5797800dc8c1ec388e546dbc06bc1d17ec41cc87d49fad682965fcaa06480fe1dd08d66c67fd982b22623d25c0c9ca5ee62607a7515e7006d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749849292"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTRN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

