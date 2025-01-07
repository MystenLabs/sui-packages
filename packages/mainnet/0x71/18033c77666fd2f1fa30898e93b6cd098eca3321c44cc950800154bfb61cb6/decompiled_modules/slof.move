module 0x7118033c77666fd2f1fa30898e93b6cd098eca3321c44cc950800154bfb61cb6::slof {
    struct SLOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOF>(arg0, 6, b"SLOF", b"Sloth+Wolf", b"SLOF=Sloth+Wolf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DLT_7_A_Kqz_400x400_1e017a1e17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

