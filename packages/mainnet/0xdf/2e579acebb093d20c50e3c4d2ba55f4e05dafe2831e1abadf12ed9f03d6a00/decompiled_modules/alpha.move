module 0xdf2e579acebb093d20c50e3c4d2ba55f4e05dafe2831e1abadf12ed9f03d6a00::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA>(arg0, 6, b"ALPHA", b"ALPHA-152", b"Alpha-152", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pz_Lw6beix5s_Ss81ts_NUW_Rki_Ns_M8uwhk8_Hyzk8k611rve_1_6d5d66a04c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

