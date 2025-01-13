module 0x61b5a7d64ba40afee3eac29e8f9aeaeb6e55b71c8a182a05d0a00d59aafbedf1::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"BLUE", b"BlueFood by SuiAI", b"The world's first sustainable Marine Fishery Token ($BLUE).To promote sustainable blue food development and maintain marine fishery resources.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/8_Jnjwrb_V_400x400_29458433f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

