module 0x29f38a477d39e608ca022c1ba0eb09d01981aac27a121d233500b40edc59133c::btsui {
    struct BTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTSUI>(arg0, 6, b"BTSUI", b"OFFICIAL BABY TRUMP ON SUI", x"42616279205472756d7020697320686572652d74686520686f7474657374206e6577206d656d6520636f696e206f6e207468652053756920626c6f636b636861696e21200a496e73706972656420627920446f6e616c64205472756d7073205452554d5020636f696e2c2042616279205472756d70206272696e6773206578636974656d656e742c2066756e2c20616e6420636f6d6d756e6974792d64726976656e20766962657320746f207468652063727970746f20776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6023_c8da33c75d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

