module 0x2047ae4f4cf929a41db672a21b75814e33eab45500f7e43a122fe57feba890a9::but {
    struct BUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUT>(arg0, 9, b"BUT", b"Sadbutrich", b"stay rich ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a2a2814-1b81-4be9-9837-5475cc7b0ac3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

