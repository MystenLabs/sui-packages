module 0x2dd7f5d49071cab77930e7f363da196e2ab9c4e79ae03f2f52cd06de11ddd6f2::amu {
    struct AMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMU>(arg0, 9, b"AMU", b"AmongUs ", b"being an imposter of your own self. inspiration from the game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e93df5c-03ba-4ef9-9f28-e789a795d851.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

