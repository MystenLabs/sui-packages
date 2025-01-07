module 0x31eb4f619c7c26c27eba4b6ca564e7cae1a74d36b82abe4c630c5a012c04594b::bossbb {
    struct BOSSBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSSBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSSBB>(arg0, 6, b"BOSSBB", b"BOSS BABY ON SUI", b"$BOSSBB is a meme coin. Identifies as a BOSS BABY Meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_Ishuk_XUAE_88_Nr_removebg_preview_afaacff855.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSSBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSSBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

