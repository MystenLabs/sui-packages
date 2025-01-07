module 0x36ba7eb702c7341f169ea604f334cd8888bb2b98aab4b9ef5eeb254989ed9d4e::wcoin {
    struct WCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCOIN>(arg0, 9, b"WCOIN", b"W coin", b"Wcoin is a meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc6af888-f7e1-42ff-b76a-5b0fc640e868.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

