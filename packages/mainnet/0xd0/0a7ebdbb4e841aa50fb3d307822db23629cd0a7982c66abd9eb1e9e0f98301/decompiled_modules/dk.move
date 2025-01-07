module 0xd00a7ebdbb4e841aa50fb3d307822db23629cd0a7982c66abd9eb1e9e0f98301::dk {
    struct DK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DK>(arg0, 6, b"DK", b"Just A Chill Donkey Fr", b"Just a Chill Donkey Fr, chillin in Shrek's swamp fr! Community Token, Dev is not selling til 1$ minimum , at this point I will take out my initial investment and try to stabilize the coin to last a life time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4m87_FF_8osn_NWU_48_A8_PYJM_Ey7i_A4f_Li_KXGE_Trju_S_Apump_b55875dca1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DK>>(v1);
    }

    // decompiled from Move bytecode v6
}

