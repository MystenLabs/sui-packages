module 0xd3c7b82fee11002c1e50f893d906e47e53119b38641e5eeb334d2c93d46ee568::rony {
    struct RONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONY>(arg0, 6, b"RONY", b"Sui Rony", b"$RONY. The most memeable memecoin in deep sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_55_9abd05cbb8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

