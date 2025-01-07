module 0x50247d59d2e5a89cfc31df171043131270682fef041f743b018054412713799b::we_cool {
    struct WE_COOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WE_COOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WE_COOL>(arg0, 9, b"WE_COOL", b"weco", b"I was inspired on youtube", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c265c9c1-e984-4b35-b4c9-3c38be060bef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WE_COOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WE_COOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

