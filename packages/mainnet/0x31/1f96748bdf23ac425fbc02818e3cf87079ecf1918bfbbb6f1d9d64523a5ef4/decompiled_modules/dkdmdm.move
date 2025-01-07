module 0x311f96748bdf23ac425fbc02818e3cf87079ecf1918bfbbb6f1d9d64523a5ef4::dkdmdm {
    struct DKDMDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKDMDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKDMDM>(arg0, 9, b"DKDMDM", b"Dkkdkd", b"Dmdmnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e32ea47-d644-4248-be1b-e983c8001386.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKDMDM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKDMDM>>(v1);
    }

    // decompiled from Move bytecode v6
}

