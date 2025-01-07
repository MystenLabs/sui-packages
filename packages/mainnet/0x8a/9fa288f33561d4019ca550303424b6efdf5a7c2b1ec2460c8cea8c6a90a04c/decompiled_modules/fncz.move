module 0x8a9fa288f33561d4019ca550303424b6efdf5a7c2b1ec2460c8cea8c6a90a04c::fncz {
    struct FNCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNCZ>(arg0, 9, b"FNCZ", b"KONz", b"Smoking is harmful to health, everyone should not smoke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04b4bd04-ed4a-4ad5-b8b3-b9bbc58685af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

