module 0xbe35bc75f5290e8d7522871d4d9ee8de44ad83ec41b412e82f1d36de0cc5461e::any {
    struct ANY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANY>(arg0, 9, b"ANY", b"Anonymous", b"No name, no face, no identity & no nothing. Nobody knows us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a31bd654-7c94-41f1-a884-39019a7c37d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANY>>(v1);
    }

    // decompiled from Move bytecode v6
}

