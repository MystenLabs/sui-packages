module 0xdc604311a38d550de8107ee6d8c4c5a99501f8822c7b413b940ff63cad1569bd::uafree {
    struct UAFREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UAFREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UAFREE>(arg0, 9, b"UAFREE", b"Ukraina ", b"Help so that Ukrainian people don't die anymore!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2082b46d-25c7-4e33-87e3-6b9be601b1a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UAFREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UAFREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

