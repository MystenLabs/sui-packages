module 0xf4716b042106a8864ab774db55b50b74c068db42ae655174636d843401567f5e::gz {
    struct GZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GZ>(arg0, 9, b"GZ", b"Gaze", b"Meme to lfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ff1cce9-554b-4c4a-bf04-e10180ee46f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

