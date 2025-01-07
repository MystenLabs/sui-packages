module 0xdae05491617ab92fe1d0f4e0b6be57816fc23bb6e24cf571dde53d3c16c35e89::owly {
    struct OWLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWLY>(arg0, 6, b"OWLY", b"OWLY BY MATT FURIE", b"$OWLY by MATT FURIE One of 1,000 Hedz. Hand drawn by Matt Furie on planet Earth in 2022.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000114541_5572769bd4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

