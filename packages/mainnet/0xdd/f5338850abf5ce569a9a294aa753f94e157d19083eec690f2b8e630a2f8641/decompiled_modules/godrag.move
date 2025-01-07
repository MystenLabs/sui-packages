module 0xddf5338850abf5ce569a9a294aa753f94e157d19083eec690f2b8e630a2f8641::godrag {
    struct GODRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODRAG>(arg0, 9, b"GODRAG", b"GokuDragon", b"A wewe(sui) based meme that has greater potential than Goku sama himself in terms of wealth and strength ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac611f6c-1b35-4eee-9f02-70a35abdb4d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODRAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODRAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

