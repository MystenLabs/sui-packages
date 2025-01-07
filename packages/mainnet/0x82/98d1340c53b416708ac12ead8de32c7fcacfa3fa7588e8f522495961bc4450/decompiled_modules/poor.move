module 0x8298d1340c53b416708ac12ead8de32c7fcacfa3fa7588e8f522495961bc4450::poor {
    struct POOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOR>(arg0, 6, b"POOR", b"POORCoin", b"Just a token for Poor people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_a_highly_detailed_cinematic_illustration_of_a_2_73c1cd20d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

