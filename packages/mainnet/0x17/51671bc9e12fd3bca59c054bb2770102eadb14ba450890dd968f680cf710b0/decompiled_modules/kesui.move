module 0x1751671bc9e12fd3bca59c054bb2770102eadb14ba450890dd968f680cf710b0::kesui {
    struct KESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KESUI>(arg0, 6, b"Kesui", b"KESUI", b"Happy to see SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_69_e08ad1516f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

