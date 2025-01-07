module 0x7c0dcc1f7eb610d2bd2dba0c440f2edb7962944f878c7bca25839aeeba4f6a2::smashie {
    struct SMASHIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASHIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMASHIE>(arg0, 6, b"SMASHIE", b"SMASHIE THE PICKLEBALL", b"$SMASHIE is a pickleball addict with a burning desire for crypto stardom on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zzrn_Sk_Mo_400x400_7f38621e75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMASHIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMASHIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

