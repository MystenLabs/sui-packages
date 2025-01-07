module 0xb07122ccd7a14ec98b6367404236923a8f3e137442f4b50705dd4307fcba181::suipox {
    struct SUIPOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOX>(arg0, 6, b"SUIPOX", b"Sui Pox CTO", x"53756920506f78202824535549504f58292069732061206d656d65636f696e2077697468206120756e6971756520636f6e636570742c20696e7370697265642062792074686520696e66616d6f7573207570636f6d696e6720224d6f6e6b6579205669727573222e200a0a466972737420446576204a656574656420666f7220627572676572206d6f6e65792e20576520636f6d65206261636b206265747465722c207769746820612066616972206c61756e636820616e642073686f772068696d206a75737420686f77206461726b206d69636869207265616c6c792069732e20200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_0eb8ce36d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

