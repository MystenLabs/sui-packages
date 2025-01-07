module 0xb915dc5189da771f1d49b166a75d9b9621b09ed20d7a7bd0dbad60f8206e9744::drgt {
    struct DRGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRGT>(arg0, 9, b"DRGT", b"DRAGBIT", b"A bitcoin dragon meme.. Whoom!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94c74a9e-cabf-4b97-a5a5-d35511c8f0aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

