module 0x4e7a37031fb3276d786b71d4aed4479f91f697879053b3d70b9c71a456cfed50::kami {
    struct KAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMI>(arg0, 9, b"KAMI", b"Omikami ", b"To flip shib", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7aa3123f-2f8a-4ef8-99a0-9ee4571732dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

