module 0x4b9925a76e6cb788c67c7c26a2e78b0ce071338fc883330bb86d73e839387dcf::tsuka {
    struct TSUKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUKA>(arg0, 6, b"TSUKA", b"Dejitaru Tsuka Sui", x"756e6c656173682074686520706f776572206f6620647261676f6e20245453554b410a0a68747470733a2f2f7777772e64656a69746172757473756b617375692e66756e2f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/koin_naga_min_071b708f9a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

