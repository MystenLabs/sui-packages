module 0xa87a44ae8e8eca3fabfc6775167f0d0e31ad2873268f0eb53a2ac3815f54d9b0::suiteam6 {
    struct SUITEAM6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEAM6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEAM6>(arg0, 6, b"SUITEAM6", b"SUITEAM-6", x"5355495445414d362069736ee2809974206a75737420616e6f74686572206d656d6520636f696e2c206974e28099732061206d697373696f6e2d64726976656e206d6f76656d656e742e20496e737069726564206279205345414c205465616d20362c207765e2809972652074686520636f76657274206f7073207465616d206f662074686520626c6f636b636861696e2c2068656c70696e6720757365727320747261636b20646f776e207363616d73202620696e7665737469676174696e672073686164792070726f6a656374732e205355495445414d36206973206865726520746f2070726f746563742c2073657276652c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736186358128.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITEAM6>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEAM6>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

