module 0x82657162bf26a0ca6e74e276389e72c151bf9a634ac9856e7694620aee2575b3::ponk {
    struct PONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONK>(arg0, 6, b"PONK", b"Chompy Ponk", x"57686f20697320504f4e4b3f0a0a4f6e63652061206368696c64686f6f642066616e7461737920612073696c6c79206c6974746c6520746f6f74686c657373206d6f6e737465722074686174206d616465207573206c61756768207768656e206e6f206f6e6520656c736520636f756c640a4e6f772c20504f4e4b206861732062726f6b656e20667265652066726f6d20746865207265616c6d206f6620647265616d7320616e642074616b656e20746f2074686520626c6f636b636861696e20746f206265636f6d65207468652066616365206f66206d617968656d2c206d656d65732c20616e6420646567656e65726174652066756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicscfly636q3oazigx5utlbscw7qxqui72pdjafbuapwdmt2jfvpe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PONK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

