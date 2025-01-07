module 0x9347f5eb6eed8bd9f632c894913ddd83d49afcd4354ce534249372186817fff3::pir {
    struct PIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIR>(arg0, 9, b"PIR", b"DISSA PIR", b"DI SSA PIR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56905cd5-f6c8-46ab-b34b-14f9a67fddbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

