module 0x20cf44048096de4c7b278230d52ef3a192043896e350eb42d1b342fbdffc30cb::chppa {
    struct CHPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHPPA>(arg0, 9, b"CHPPA", b"CHOPPA", b"Choppa token is a meme token, choppa is a slang word meaning automatic weapon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80420e6a-8f1e-4058-a916-26f5652a7055.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

