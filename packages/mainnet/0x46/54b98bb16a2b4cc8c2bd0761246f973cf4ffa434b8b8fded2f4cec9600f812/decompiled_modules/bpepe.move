module 0x4654b98bb16a2b4cc8c2bd0761246f973cf4ffa434b8b8fded2f4cec9600f812::bpepe {
    struct BPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPEPE>(arg0, 6, b"bPEPE", b"Blastin Pepes", b"Blastin Pepes sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rzt_E_Sfn_400x400_8e917316e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

