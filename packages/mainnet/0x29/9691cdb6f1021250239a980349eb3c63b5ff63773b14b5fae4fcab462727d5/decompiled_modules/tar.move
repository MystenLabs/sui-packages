module 0x299691cdb6f1021250239a980349eb3c63b5ff63773b14b5fae4fcab462727d5::tar {
    struct TAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAR>(arg0, 6, b"TAR", b"Tardigrade", b"will live under any circumstances", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_g_A_r_A_nt_A_s_A_2024_11_14_125008_eade58b79b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

