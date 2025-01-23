module 0x9195e48f592616e6903d53365aa341ff8a069da27a89e4d06493a938386681fd::matu {
    struct MATU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATU>(arg0, 6, b"MATU", b"Matu the Defiled Giraffe", x"4d61747520776173206120322d796561722d6f6c642067697261666665206d696e64696e672068697320627573696e65737320696e206120546f726f6e746f207a6f6f207768656e2074686520617574686f726974696573206465636964656420746f2063617374726174652068696d2e2048652064696564206f6e20746865206f7065726174696e67207461626c652e0a0a4e6f206361702e204a75737469636520666f72204d6174752e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250124_022826_696_076bb5d18b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATU>>(v1);
    }

    // decompiled from Move bytecode v6
}

