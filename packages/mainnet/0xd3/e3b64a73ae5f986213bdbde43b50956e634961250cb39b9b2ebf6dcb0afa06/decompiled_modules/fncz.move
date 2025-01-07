module 0xd3e3b64a73ae5f986213bdbde43b50956e634961250cb39b9b2ebf6dcb0afa06::fncz {
    struct FNCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNCZ>(arg0, 9, b"FNCZ", b"KONz", b"Smoking is harmful to health, everyone should not smoke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fdfc7f56-f3b7-48f8-a3b4-194ed7fc3201.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

