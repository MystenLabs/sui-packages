module 0x8297c86ad987d537df750d2c66031f04771ea56e9b613fdef7184f6dc2b87886::rvr {
    struct RVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RVR>(arg0, 9, b"RVR", b"River ", b"This token is coined from the river ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d981eb4a-e64b-41bb-9a27-13085cf77c1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RVR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RVR>>(v1);
    }

    // decompiled from Move bytecode v6
}

