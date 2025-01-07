module 0xe8d7c47aeb6e28b0079aab0769de06078afd8733fc65df07887590e511ac06a7::sunke {
    struct SUNKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNKE>(arg0, 6, b"SUNKE", b"SUNKE SUI", b"Im Sunke ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_69_2381fe9561.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

