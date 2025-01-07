module 0xc1b7df26f06c28f574200945b300bb4cceeb621ca9a6a2d301725eb9d72bffe::looco {
    struct LOOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOCO>(arg0, 9, b"LOOCO", b"LootCoin", b"LOoooOt coin trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c73c7871-620b-497f-8a54-007596d140e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOOCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

