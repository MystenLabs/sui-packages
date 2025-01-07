module 0x8a6c2d14d877a3e807f2433eb2245586c09bb43f6cc63ea6af01d5ba3c461d43::puzzle {
    struct PUZZLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUZZLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUZZLE>(arg0, 6, b"PUZZLE", b"Puzzle on Sui", b"Piece it together with $PUZZLE. Every move connects you to something bigger in the Sui Network. Solve the puzzle and unlock hidden rewards! Play the Puzzle on the Website.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_78_22814501a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUZZLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUZZLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

