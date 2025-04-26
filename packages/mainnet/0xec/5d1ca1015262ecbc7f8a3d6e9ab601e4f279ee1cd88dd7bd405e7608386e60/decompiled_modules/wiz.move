module 0xec5d1ca1015262ecbc7f8a3d6e9ab601e4f279ee1cd88dd7bd405e7608386e60::wiz {
    struct WIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZ>(arg0, 6, b"WIZ", b"Wizard Wif Hat", x"412077697a61726420776974682061206861742c206120646567656e2077697468206120647265616d2e202457495a206973206865726520746f2063617374207370656c6c73206f6e2074686520537569207472656e636865732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wizardwifhat_ezgif_com_optiwebp_1_1_1_d5eec83bee.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

