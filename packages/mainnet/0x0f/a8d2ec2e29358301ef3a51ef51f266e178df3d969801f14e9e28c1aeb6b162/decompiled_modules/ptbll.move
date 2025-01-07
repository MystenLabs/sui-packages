module 0xfa8d2ec2e29358301ef3a51ef51f266e178df3d969801f14e9e28c1aeb6b162::ptbll {
    struct PTBLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTBLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTBLL>(arg0, 6, b"PTBLL", b"Pitbull", b"READY TO BITE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_Al_Ae_nt_Ae_s_Ae_35b3101049.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTBLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTBLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

