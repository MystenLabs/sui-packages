module 0x2ba5712d54bd23627f5f176097a08a0b94ed08d8f1dd49c0e8df17af867826cb::farm {
    struct FARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARM>(arg0, 9, b"FARM", b"Fish", b"Farm fish token to earn ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f689d997-4757-4fa3-ad75-1bcb9ba524aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

