module 0x9d372dc7dce67833c68212ee4f94f269904246881b443c3f52eeaeff7adf297a::hrb {
    struct HRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRB>(arg0, 9, b"HRB", b"Harambee", b"Working together for freedom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30dde538-6ac2-4565-8107-9462b4a75dbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

