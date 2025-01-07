module 0xe1248eb592100a2f1c575f9bc84742f0a0a7f9fd5afdadd0236171b0e06eca42::pola {
    struct POLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLA>(arg0, 6, b"POLA", b"Polacoinbear", x"546869732070726f6a6563742061696d7320746f2062652061206c6f6e672d7465726d206f6e6520616e640a68656c7020706f6c617220626561727320696e206576657279207761792077652063616e0a7468726f7567682024504f4c41206d656d65636f696e2e2041732053554920657870616e64732c0a77652077616e7420746f2062652070617274206f6620746869732068756765206a6f75726e657920746f0a6f6e626f6172642070656f706c6520616c6c2061726f756e642074686520776f726c6420746f0a63727970746f207468726f756768206d656d6574696320706f77657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731009881860.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

