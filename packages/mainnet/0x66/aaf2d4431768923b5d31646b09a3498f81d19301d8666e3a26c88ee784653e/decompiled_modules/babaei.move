module 0x66aaf2d4431768923b5d31646b09a3498f81d19301d8666e3a26c88ee784653e::babaei {
    struct BABAEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABAEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABAEI>(arg0, 9, b"BABAEI", b"Sheet", b"Lets take the sheep to the top ; higher than the dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/228e02ec-5a42-4081-ae38-f5569adaa054.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABAEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABAEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

