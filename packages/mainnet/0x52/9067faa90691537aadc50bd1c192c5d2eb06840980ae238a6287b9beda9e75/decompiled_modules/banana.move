module 0x529067faa90691537aadc50bd1c192c5d2eb06840980ae238a6287b9beda9e75::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 9, b"BANANA", b"BA NA NA", b"BAN ANA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f58b173-6ec1-48c6-a342-2b8316d60d81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

