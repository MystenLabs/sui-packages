module 0x3b45a86a5c501ec617a6ca9ee3ce2c24967201d1275b8ea4c7590465e5897763::spice {
    struct SPICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPICE>(arg0, 9, b"SPICE", b"SuiSpice", b"Bringing a little extra heat to your portfolio! $SPICE on the Sui network is all about adding flavor to the meme space with spicy contests, hot giveaways, and a community of daring investors", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc42dc70-73a3-45dc-8675-43fd2729bdc4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

