module 0x6a3d064c606c49d8c5a0e2aaf2e635267c3bff50debc72b8032fa2ad3141bcbd::suideer {
    struct SUIDEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEER>(arg0, 6, b"Suideer", b"suideer", b"Sui deer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241010103709_f844eaef8f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

