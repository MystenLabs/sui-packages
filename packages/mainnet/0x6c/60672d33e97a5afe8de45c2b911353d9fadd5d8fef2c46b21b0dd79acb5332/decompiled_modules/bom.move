module 0x6c60672d33e97a5afe8de45c2b911353d9fadd5d8fef2c46b21b0dd79acb5332::bom {
    struct BOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOM>(arg0, 6, b"BOM", b"BagOfMemes", b"Lets push this gem after devs rugged it multiple times", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qj_Jk_Jivg6_Ccz_Wo_K6kx_K_Vc8v_K_Fb97yt8zrz_J_Fif6_G5_Ejb_900de1465f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

