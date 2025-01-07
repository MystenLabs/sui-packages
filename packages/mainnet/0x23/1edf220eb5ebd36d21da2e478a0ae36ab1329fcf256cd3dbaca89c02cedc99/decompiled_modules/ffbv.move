module 0x231edf220eb5ebd36d21da2e478a0ae36ab1329fcf256cd3dbaca89c02cedc99::ffbv {
    struct FFBV has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFBV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFBV>(arg0, 9, b"FFBV", b"HH", b"BV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/072976c4-f723-4bbd-8ced-553d43687a1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFBV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFBV>>(v1);
    }

    // decompiled from Move bytecode v6
}

