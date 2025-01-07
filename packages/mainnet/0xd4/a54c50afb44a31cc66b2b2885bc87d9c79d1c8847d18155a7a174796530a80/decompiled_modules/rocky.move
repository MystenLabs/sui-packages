module 0xd4a54c50afb44a31cc66b2b2885bc87d9c79d1c8847d18155a7a174796530a80::rocky {
    struct ROCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKY>(arg0, 6, b"ROCKY", b"RockyonSui", b"Rocky the dog: Named after Solana Co-Founder Raj Gokals dog Rocky.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_N_Lp_ML_Yk_400x400_508cc5e53d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

