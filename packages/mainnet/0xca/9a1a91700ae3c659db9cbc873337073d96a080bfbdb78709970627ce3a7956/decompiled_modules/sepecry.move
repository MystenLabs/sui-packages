module 0xca9a1a91700ae3c659db9cbc873337073d96a080bfbdb78709970627ce3a7956::sepecry {
    struct SEPECRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEPECRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEPECRY>(arg0, 6, b"SEPECRY", b"Sepe Cry", b"SEPECRY is crying because all crypto is dying!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_2_8bd7c0adb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEPECRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEPECRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

