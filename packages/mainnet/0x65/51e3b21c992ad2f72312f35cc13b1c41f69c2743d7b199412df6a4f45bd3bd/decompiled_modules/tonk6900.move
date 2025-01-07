module 0x6551e3b21c992ad2f72312f35cc13b1c41f69c2743d7b199412df6a4f45bd3bd::tonk6900 {
    struct TONK6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONK6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONK6900>(arg0, 6, b"TONK6900", b"SUI TONK6900", b"$STONK6900 ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ct_Hs_Azx_400x400_b9e773de7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONK6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONK6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

