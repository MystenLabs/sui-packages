module 0x6b7a480c6cae5b66df3e7cc67582f8282107729ef9987b1f5af0613ce6ff0dd7::pns {
    struct PNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNS>(arg0, 9, b"PNS", b"PANDA SUI", b"Hehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4534b902-7934-45b3-9653-051f3c848d25.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

