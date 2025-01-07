module 0x5ccc8533f20fad6dadc2183f45bac900310194d6e9322e8a905f2b7fa63cf2ff::bamfish {
    struct BAMFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAMFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAMFISH>(arg0, 6, b"BAMFISH", b"Bam the fish", b"That face you make when you finally figure out whats going on.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_074028_bb229af3dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAMFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

