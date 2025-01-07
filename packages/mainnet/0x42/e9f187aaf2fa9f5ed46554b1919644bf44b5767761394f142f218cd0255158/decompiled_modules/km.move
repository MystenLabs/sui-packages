module 0x42e9f187aaf2fa9f5ed46554b1919644bf44b5767761394f142f218cd0255158::km {
    struct KM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KM>(arg0, 6, b"Km", b"Kekius maximus", b"We go to the moon in 2025...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003521_c50977bb5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KM>>(v1);
    }

    // decompiled from Move bytecode v6
}

