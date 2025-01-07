module 0x5501c973e21249f3ab58d89cf510d9aa10dae93cfbbb0a25dd1eb2be9df8c837::suichi {
    struct SUICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHI>(arg0, 6, b"SUICHI", b"Foochi SUI", b"Foochi is the fluffiest, most colorful coin on Solana, bringing joy and doodle vibes to your wallet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S3ei_E26_Q_400x400_b7b2b7d74d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

