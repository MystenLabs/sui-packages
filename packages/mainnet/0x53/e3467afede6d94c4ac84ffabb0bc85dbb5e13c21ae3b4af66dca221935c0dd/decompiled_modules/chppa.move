module 0x53e3467afede6d94c4ac84ffabb0bc85dbb5e13c21ae3b4af66dca221935c0dd::chppa {
    struct CHPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHPPA>(arg0, 9, b"CHPPA", b"CHOPPA", b"Choppa token is a meme token, choppa is a slang word meaning automatic weapon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8db55ba9-1b81-49fc-a3c5-9d5277148fd6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

