module 0xba76a740e3b2d5d2818e32dc5210af30789bb9f1701b76c295782bbcc41d1888::poke_sui {
    struct POKE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKE_SUI>(arg0, 9, b"pokeSUI", b"Poke Staked SUI", b"Infinitely liquid staking on Sui for Pokemon enjoyoors! Liquid Suicune Token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/file/d/1cG3i4bfO5NuHxbHMuTo8ze5Z9vvzo-y5/view?usp=drive_link")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKE_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKE_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

