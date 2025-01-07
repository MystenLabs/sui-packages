module 0x7cd46743884f00a3cd6db2604c7611ca3d9706fd018b8ac89ce2f8bec7fe83f::trmpz {
    struct TRMPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMPZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMPZ>(arg0, 6, b"TRMPZ", b"TrumpZter", b"For the meme lovers, truth seekers, and those ready to laugh through the chaos. Join the Trumpzter movement and lets keep it real.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_11_16_T212653_775_bb5db2a10c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMPZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRMPZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

