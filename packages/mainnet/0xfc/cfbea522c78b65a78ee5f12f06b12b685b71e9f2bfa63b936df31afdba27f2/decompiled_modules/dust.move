module 0xfccfbea522c78b65a78ee5f12f06b12b685b71e9f2bfa63b936df31afdba27f2::dust {
    struct DUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUST>(arg0, 9, b"DUST", b"Dust2dust", b"Dust the ultimate meme to remind you about memecoins and dust rewards ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03a4f763-8797-469a-b827-2ab483a7001e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

