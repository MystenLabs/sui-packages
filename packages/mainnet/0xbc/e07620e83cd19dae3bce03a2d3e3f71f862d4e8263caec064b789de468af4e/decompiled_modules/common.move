module 0xbce07620e83cd19dae3bce03a2d3e3f71f862d4e8263caec064b789de468af4e::common {
    struct COMMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMON>(arg0, 9, b"COMMON", b"Common", b"Everything is common no rare, epic, legendary or special", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dcf2a7c4-3eed-4823-acab-ab8d752101f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

