module 0x278ed04cafcf659442a65838267491d3a09e33f389ccde47bcca203ff3644009::blucabam {
    struct BLUCABAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUCABAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUCABAM>(arg0, 6, b"BLUCABAM", b"BLUCABAM SUI", b"BLUCABAM  Fish in the Waters of the Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/81631f5c6f20426ee5a26595b58cf33d_145a5b1e3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUCABAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUCABAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

