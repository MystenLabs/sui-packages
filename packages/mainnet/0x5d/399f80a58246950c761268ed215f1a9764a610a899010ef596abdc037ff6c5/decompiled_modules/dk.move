module 0x5d399f80a58246950c761268ed215f1a9764a610a899010ef596abdc037ff6c5::dk {
    struct DK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DK>(arg0, 9, b"DK", b"Didnt", b"Kick it out the window for ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf86c849-8ab3-4911-ab2d-0067345e1133.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DK>>(v1);
    }

    // decompiled from Move bytecode v6
}

