module 0x674aa28e511a3be092e08fa92b67facfc7d51b290b309063588ff6368eb425e::smog {
    struct SMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOG>(arg0, 9, b"SMOG", b"Smog the Destroyer", b"I am Smog! Chiefest of calamities! Destroyer of meme coins! Don't fade me becoz I'm smol, I will fly over tha fields and rip your meme coins to widdle pieces. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/662a58947731d0b9b59a721781183d56blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

