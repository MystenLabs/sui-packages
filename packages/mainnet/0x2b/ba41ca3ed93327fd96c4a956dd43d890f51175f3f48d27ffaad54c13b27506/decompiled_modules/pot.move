module 0x2bba41ca3ed93327fd96c4a956dd43d890f51175f3f48d27ffaad54c13b27506::pot {
    struct POT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POT>(arg0, 6, b"POT", b"SUIPOT", b"SUIPOT The lucky cat meme from the jackpot game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R9www_Qd_R_400x400_32645ec544.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POT>>(v1);
    }

    // decompiled from Move bytecode v6
}

