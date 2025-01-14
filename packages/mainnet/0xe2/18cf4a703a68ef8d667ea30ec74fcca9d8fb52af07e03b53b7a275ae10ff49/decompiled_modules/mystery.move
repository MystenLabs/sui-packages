module 0xe218cf4a703a68ef8d667ea30ec74fcca9d8fb52af07e03b53b7a275ae10ff49::mystery {
    struct MYSTERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MYSTERY>(arg0, 6, b"MYSTERY", b"TheMysteryOfSui by SuiAI", b"The Mystery Of Sui will be bringing further attention to the Sui network and community with our secret road map .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/OLOS_Pbho_400x400_f48878509c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MYSTERY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTERY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

