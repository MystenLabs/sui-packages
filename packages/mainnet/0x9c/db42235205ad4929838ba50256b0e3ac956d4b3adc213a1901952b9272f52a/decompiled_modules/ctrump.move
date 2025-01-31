module 0x9cdb42235205ad4929838ba50256b0e3ac956d4b3adc213a1901952b9272f52a::ctrump {
    struct CTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTRUMP>(arg0, 9, b"CTRUMP", b"C.Trump", b"This is a coin to acknowledge President Trump a True Hero.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a0901f4-6705-4e1d-9422-fcc75443a097.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

