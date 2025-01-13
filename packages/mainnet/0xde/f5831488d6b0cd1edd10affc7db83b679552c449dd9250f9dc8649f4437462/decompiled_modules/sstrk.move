module 0xdef5831488d6b0cd1edd10affc7db83b679552c449dd9250f9dc8649f4437462::sstrk {
    struct SSTRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSTRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSTRK>(arg0, 6, b"SSTRK", b"Sui Strike", x"4a6f696e2074686520756c74696d6174652062726f777365722d626173656420626174746c65206172656e612c2064657369676e656420746f206272696e67207468652053554920636f6d6d756e69747920746f6765746865722e20506c61792c20636f6e6e6563742c20616e6420646f6d696e6174652074686520626174746c656669656c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_13_16_07_22_A_cartoonish_portrait_of_a_confident_soldier_in_a_modern_combat_uniform_The_soldier_wears_a_tactical_helmet_with_goggles_a_rugged_vest_with_gear_an_6afbe0fa85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSTRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSTRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

