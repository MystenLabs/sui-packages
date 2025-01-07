module 0xd2cd247920c305cfcd7b3f155c48c4dcc11936de048a5b9b3d3393ab5d985b5::epet {
    struct EPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPET>(arg0, 9, b"EPET", b"Eagle Pet", b"Eagle pet meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/507e306d-d5ba-4440-a6ec-380ae6a7d7e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EPET>>(v1);
    }

    // decompiled from Move bytecode v6
}

