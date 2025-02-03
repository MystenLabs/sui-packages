module 0x32ac07ad325e1e5256b86dc0c0da16e94d0d79041fda7d01787367d4015c2310::yolksui {
    struct YOLKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLKSUI>(arg0, 6, b"YOLKSUI", b"SuiYolk", b"Sui Yolk - Where everyone belongs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_9_a361bc66a1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

