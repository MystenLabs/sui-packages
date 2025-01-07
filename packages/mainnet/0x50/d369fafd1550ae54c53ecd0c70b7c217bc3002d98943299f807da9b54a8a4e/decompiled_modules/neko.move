module 0x50d369fafd1550ae54c53ecd0c70b7c217bc3002d98943299f807da9b54a8a4e::neko {
    struct NEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKO>(arg0, 6, b"NEKO", b"NEKO SUI", b"Coming from Sui network Layer 1, $NEKO is here to become the top cat meme on sui and send your pockets to the moon  $NEKO is ready to pump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_21_5fab04cad9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

