module 0x8c1aad9bf2286d8aed5d5ad44626ef2c8ae850f2400036eb27548457e5941bf8::suiyan {
    struct SUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYAN>(arg0, 6, b"SUIYAN", b"SUIYAN CAT", b"Suiyan is the most annoying cat on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_22_235342_061e6694a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

