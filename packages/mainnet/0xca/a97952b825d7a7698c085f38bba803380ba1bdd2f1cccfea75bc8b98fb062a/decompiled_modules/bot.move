module 0xcaa97952b825d7a7698c085f38bba803380ba1bdd2f1cccfea75bc8b98fb062a::bot {
    struct BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOT>(arg0, 9, b"BOT", b"Botak Bah", b"Botak", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26759474-de71-4bbe-a4e1-077dea833d5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

