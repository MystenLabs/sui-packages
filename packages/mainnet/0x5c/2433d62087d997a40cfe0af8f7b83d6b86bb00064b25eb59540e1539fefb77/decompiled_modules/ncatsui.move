module 0x5c2433d62087d997a40cfe0af8f7b83d6b86bb00064b25eb59540e1539fefb77::ncatsui {
    struct NCATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCATSUI>(arg0, 6, b"NCATSUI", b"Neuracattoken", b"NCAT on Solana  The First Neuracat Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_N_Wb2_Tf_400x400_4a8085700f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NCATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

