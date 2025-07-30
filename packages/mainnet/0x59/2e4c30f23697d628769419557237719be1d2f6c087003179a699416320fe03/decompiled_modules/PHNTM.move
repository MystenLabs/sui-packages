module 0x592e4c30f23697d628769419557237719be1d2f6c087003179a699416320fe03::PHNTM {
    struct PHNTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHNTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHNTM>(arg0, 6, b"Neon Phantom", b"PHNTM", b"A meme coin for the cyberpunk rebels. PHNTM embodies the neon-lit, high-tech underground where hackers and outcasts thrive. Trade it in the shadows, wield it like a digital blade, and embrace the chaos of the decentralized future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/8utpWSEa3coxDtFuRY0UQg2OF75W6vWggImXTSi0LaJ4vfiKA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHNTM>>(v0, @0xdfbc0bca5f7ab287e65359124a2abf5cad98f8b6b7624819a650050338195689);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHNTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

