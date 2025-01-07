module 0xebb8eacffbb8e8adda15d9677307f1851ddc0093da7767c66d2c02d7562727a::drp {
    struct DRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRP>(arg0, 6, b"DRP", b"Droppy", b"Play the Droppy on Sui Telegram minigame and earn points!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zrzut_ekranu_2024_09_18_135736_905f45dfaf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

