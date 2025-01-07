module 0xbe96489d52eae37f55085948727e1d786ffd0d1b1fccdb2d9699e4cba49dc1a9::bruhcat {
    struct BRUHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUHCAT>(arg0, 9, b"BRUHCAT", b"Bruh Cat", b"Cat meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/933aa263-0df1-44af-b4d5-25ec62f53274.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRUHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

