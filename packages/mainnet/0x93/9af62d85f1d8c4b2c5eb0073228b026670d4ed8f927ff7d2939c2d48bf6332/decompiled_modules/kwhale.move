module 0x939af62d85f1d8c4b2c5eb0073228b026670d4ed8f927ff7d2939c2d48bf6332::kwhale {
    struct KWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWHALE>(arg0, 6, b"KWHALE", b"Killer Whale", b"Forget Pepe. The future belongs to $KWHALE. Launching on the SUI chain, this isn't just a memecoin; it's a movement. Join the wave, grab your share, and ride the $KWHALE to the moon. The time for domination is now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_25787be3f9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

