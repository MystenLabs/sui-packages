module 0xb0fc2f250eea58233d50128e719a042417ca270484dbea1896e1ad4e82b7bbe5::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"SuiDog", b"Sui Watch Dog", x"496e74726f647563696e672053756920446f67202d207468652061726d6f726564207761746368646f67206f66207468652053756920636861696e2e204465636b6564206f757420696e2066756c6c2072696f7420676561722c207468697320666561726c657373204b392069736ee2809974206865726520746f20736974206f722066657463682e204865e2809973206865726520746f206261726b20646f776e207363616d732c2062697465204655442c20616e64206c6561642061206d656d65746963207570726973696e67206163726f73732074686520646563656e7472616c697a65642066726f6e746965722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749516593135.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

