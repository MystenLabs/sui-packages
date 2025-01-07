module 0x7fb79f87ac385dd99a1ac2dbdd8959961200beaf7629396eac56a70ad949d5c5::frgg {
    struct FRGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRGG>(arg0, 9, b"FRGG", b"Froggie", b" Ribbit-rich coins for frog-lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dca35eb4-8406-4274-80cc-97e60ff06872.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

