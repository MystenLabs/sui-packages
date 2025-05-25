module 0xb41470b7a74201ac354223b6c37428b7922fff0976b210a108a4a09e8bed56b9::party {
    struct PARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARTY>(arg0, 6, b"PARTY", b"SUI PARTY", b"SUI PARTY is the most festive meme coin on the SUI ecosystem: pure energy, music, and tropical island vibes! Join the party and bring the fun to the blockchain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2_52b52112c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

