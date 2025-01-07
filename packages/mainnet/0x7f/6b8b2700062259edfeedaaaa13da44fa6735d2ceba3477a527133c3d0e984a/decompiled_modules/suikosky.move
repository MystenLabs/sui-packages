module 0x7f6b8b2700062259edfeedaaaa13da44fa6735d2ceba3477a527133c3d0e984a::suikosky {
    struct SUIKOSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKOSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKOSKY>(arg0, 6, b"Suikosky", b"Suikosky S.U.I", b"BOOOO! augh arggghh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AA_adir_un_t_A_tulo_12_a6f106b6f9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKOSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKOSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

