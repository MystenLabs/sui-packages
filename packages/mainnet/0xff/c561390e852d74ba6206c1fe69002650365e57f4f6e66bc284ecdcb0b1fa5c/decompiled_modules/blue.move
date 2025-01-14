module 0xffc561390e852d74ba6206c1fe69002650365e57f4f6e66bc284ecdcb0b1fa5c::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"BLUE", b"BlueFood by SuiAI", b"The world's first sustainable Marine Fishery Token ($BLUE).To promote sustainable blue food development and maintain marine fishery resources.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/8_Jnjwrb_V_400x400_29458433f5_f812c5e27d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

