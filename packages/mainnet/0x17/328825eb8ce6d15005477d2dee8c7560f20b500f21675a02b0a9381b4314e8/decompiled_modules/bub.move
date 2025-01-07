module 0x17328825eb8ce6d15005477d2dee8c7560f20b500f21675a02b0a9381b4314e8::bub {
    struct BUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUB>(arg0, 9, b"BUB", b"BUBBIES", b"Nice token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c003e07-f820-4eff-bd92-9c03b2527784.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

