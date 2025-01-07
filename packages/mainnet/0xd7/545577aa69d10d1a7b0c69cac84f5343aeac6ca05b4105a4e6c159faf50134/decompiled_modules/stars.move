module 0xd7545577aa69d10d1a7b0c69cac84f5343aeac6ca05b4105a4e6c159faf50134::stars {
    struct STARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARS>(arg0, 9, b"STARS", b"MAJOR", b"MAJOR OF TELEGRAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b89b78e2-b084-4f8b-9070-c347aa25a70b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

