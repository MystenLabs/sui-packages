module 0xca8f479123e17c418639fdf91e6dc606a24cb17bfc9320cb9884b2c963a91da6::pepz {
    struct PEPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPZ>(arg0, 9, b"PEPZ", b"PEPERONI", b"PEPERONI is a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c562a9a-7dab-456a-b964-f1b015a0fdce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

