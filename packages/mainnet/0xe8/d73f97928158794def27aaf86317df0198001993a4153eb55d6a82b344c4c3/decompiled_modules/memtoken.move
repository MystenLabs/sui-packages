module 0xe8d73f97928158794def27aaf86317df0198001993a4153eb55d6a82b344c4c3::memtoken {
    struct MEMTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMTOKEN>(arg0, 9, b"MEMTOKEN", b"STM ", b"STM MEMTOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee383762-710b-40e8-8941-1990903e4b87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

