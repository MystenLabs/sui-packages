module 0x3debe2cbe0df08ac0483191cf6852aa0571dbee0ca52f0880fb37e693da2914a::hasbulla {
    struct HASBULLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASBULLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASBULLA>(arg0, 6, b"HASBULLA", b"First Hasbulla On Sui", b"First Hasbulla On Sui.https://www.hasbullasui.pro | https://x.com/Hasbulla_Sui | https://t.me/HasbullaSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chara_hero_768x721_a0c035d5df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASBULLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASBULLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

