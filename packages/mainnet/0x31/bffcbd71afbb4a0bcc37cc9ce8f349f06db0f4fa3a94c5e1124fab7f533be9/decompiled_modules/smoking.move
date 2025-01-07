module 0x31bffcbd71afbb4a0bcc37cc9ce8f349f06db0f4fa3a94c5e1124fab7f533be9::smoking {
    struct SMOKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKING>(arg0, 6, b"SMOKING", b"the SUIt dog", b"An elegant doggo just joined SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pescara_checkered_floor_887817_7c39eb4023.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

