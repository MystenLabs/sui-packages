module 0x701b3add809a6d3d6f1e10ae6cd2419f2b0ba79410ac759399eb7ceddcb52d9f::rivus {
    struct RIVUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIVUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIVUS>(arg0, 6, b"RIVUS", b"Sui Rivus", b"Rivus will have us all laughing, bringing a cheerful vibe to Sui!  His playful antics and infectious humor will light up the community, ensuring that every moment is filled with joy and fun. Get ready for a wave of laughter with Rivus! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_81_a7f4a5bfdb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIVUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIVUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

