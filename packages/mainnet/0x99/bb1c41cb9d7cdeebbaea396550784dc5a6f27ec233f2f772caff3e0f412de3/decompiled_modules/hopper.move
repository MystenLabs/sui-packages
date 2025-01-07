module 0x99bb1c41cb9d7cdeebbaea396550784dc5a6f27ec233f2f772caff3e0f412de3::hopper {
    struct HOPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPER>(arg0, 6, b"Hopper", b"Hopper the rabbit", b"a community-driven cryptocurrency inspired by the fast, energetic and playful spirit of rabbits. Hopper combines the power of meme culture with the accessibility of SUI blockchain, creating a vibrant, fast-growing ecosystem where anyone can join the fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_Tym_A_QK_400x400_31ad89b9f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

