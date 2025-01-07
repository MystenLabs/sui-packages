module 0xaa5ebb957ec62dbb50218b62894e9b5504d99e08baf4bb5c1c67e285835e0dae::dsaf {
    struct DSAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSAF>(arg0, 9, b"DSAF", b"DSA", b"DASF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e9c18dc-d113-467c-b2c8-a59861218868.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

