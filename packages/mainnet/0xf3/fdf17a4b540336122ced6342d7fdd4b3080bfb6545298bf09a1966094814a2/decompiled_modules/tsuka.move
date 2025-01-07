module 0xf3fdf17a4b540336122ced6342d7fdd4b3080bfb6545298bf09a1966094814a2::tsuka {
    struct TSUKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUKA>(arg0, 6, b"TSUKA", b"Dejitaru Tsuka Sui", x"756e6c656173682074686520706f776572206f6620245453554b41204f6e205355490a0a68747470733a2f2f7777772e64656a69746172757473756b617375692e66756e2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/koin_naga_min_6037caafbe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

