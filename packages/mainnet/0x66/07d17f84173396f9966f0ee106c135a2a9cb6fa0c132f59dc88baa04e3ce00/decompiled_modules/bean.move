module 0x6607d17f84173396f9966f0ee106c135a2a9cb6fa0c132f59dc88baa04e3ce00::bean {
    struct BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAN>(arg0, 6, b"BEAN", b"Bean", x"54696e7920446576696c206f66205375692052454b5420627920546865204a45455420546974616e73206f662068697320776f726c640a0a524556454e47452121210a0a49276c6c2077697065206576657279206f6e65206f66207468656d210a0a4576657279204c617374204f6e65204f662054686f7365204a45455445525320546861742773204f6e2053756921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/main_LOGO_0f02db194b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

