module 0xa3965b7ec3cce16e2b9c269c50b2917c1fb51d499e753b899c2f84d6270dc9c1::jmine {
    struct JMINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMINE>(arg0, 9, b"JMINE", b"Jauwalmini", b"For birthday party celebrating", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/885a3eef-cdda-4a83-81be-211eb42ba5b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JMINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

