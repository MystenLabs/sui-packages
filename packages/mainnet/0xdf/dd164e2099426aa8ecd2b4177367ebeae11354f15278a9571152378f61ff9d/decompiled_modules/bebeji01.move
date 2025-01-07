module 0xdfdd164e2099426aa8ecd2b4177367ebeae11354f15278a9571152378f61ff9d::bebeji01 {
    struct BEBEJI01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBEJI01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBEJI01>(arg0, 9, b"BEBEJI01", b"Danbabanmu", b"A true story of obedient from child to his father for years ago ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/735f58d6-d5c8-45b5-ba3b-3275a67db499.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBEJI01>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBEJI01>>(v1);
    }

    // decompiled from Move bytecode v6
}

