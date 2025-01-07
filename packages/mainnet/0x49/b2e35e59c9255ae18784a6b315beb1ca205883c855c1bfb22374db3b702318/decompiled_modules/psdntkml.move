module 0x49b2e35e59c9255ae18784a6b315beb1ca205883c855c1bfb22374db3b702318::psdntkml {
    struct PSDNTKML has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSDNTKML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSDNTKML>(arg0, 6, b"PSDNTKML", b"presidentKamala", b"Just Fan token of Kamala Harris. Let's pump it together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_D_D_D_D_N_2_50e31231fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSDNTKML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSDNTKML>>(v1);
    }

    // decompiled from Move bytecode v6
}

