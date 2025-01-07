module 0xf417911c935b456aa7f0fa7684c10fd6ca29175962273e7f57d1991481f78545::ftcat {
    struct FTCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTCAT>(arg0, 9, b"FTCAT", b"FortuneCat", b"The good luck cat token that brings good fortunes to your crypto trades and portfolio. Keep some of it on your wallet and watch your trades ends in profit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/591f1f34-04d4-4657-a5ad-2cd1b460f154.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

