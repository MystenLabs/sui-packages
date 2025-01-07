module 0x49e68c308ec1670c7f6501e48dda04b0227a0f6c5cb58dec229c04012d00cdf7::tigermeme {
    struct TIGERMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGERMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGERMEME>(arg0, 9, b"TIGERMEME", b"TIGER MEME", b"TIGERMEME is the best memecoin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56d644b8-3c56-478b-84e7-09db634be18b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGERMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIGERMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

