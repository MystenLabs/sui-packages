module 0xe6cb4a75ff53eb991e0b6bd203642525a71f9dcf958f747e11787b66887dd809::frogfrog {
    struct FROGFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGFROG>(arg0, 6, b"FrogFrog", b"Frog Frog", b"Frog frog has come to take their rightful place as king kitty of the Sui jungle! Jeets fear him! Nocoiners tremble at the very mention of his name... Frog Frog is inevitable...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1683302825646_e392bbea67a6fcfbfec3a0c14e10ade0_3be767ee16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

