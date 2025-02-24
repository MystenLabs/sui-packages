module 0x6638388bc3271c150b372ee92fea43909d088896af5a0bd9537851caf4004119::jasmine {
    struct JASMINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JASMINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JASMINE>(arg0, 9, b"JASMINE", b"JASMINE ", b"follow me we will moon with love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6e0256a-b593-485c-a48f-cf4f23ad3e9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JASMINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JASMINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

