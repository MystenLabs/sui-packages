module 0x93a6e36d0c55fa3a5f13e6d00eec751be7a1ea6375dcf50a810fe9acba754379::sht {
    struct SHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHT>(arg0, 9, b"SHT", b"Kal", b"Poop and fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63bbff03-e400-44a4-903a-3cb28cd62d70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

