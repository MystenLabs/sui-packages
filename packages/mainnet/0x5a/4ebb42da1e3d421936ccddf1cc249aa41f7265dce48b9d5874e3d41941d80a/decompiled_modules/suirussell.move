module 0x5a4ebb42da1e3d421936ccddf1cc249aa41f7265dce48b9d5874e3d41941d80a::suirussell {
    struct SUIRUSSELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRUSSELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRUSSELL>(arg0, 6, b"SUIRUSSELL", b"RUSSELL", x"52555353454c4c0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241011095959_c2ee08cb87.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRUSSELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRUSSELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

