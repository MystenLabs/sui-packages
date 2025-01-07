module 0x91eeef30d0cd45ae595665428706c483ba3e26bad55db2823bf64f58d99350e6::sov {
    struct SOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOV>(arg0, 9, b"SOV", b"Solver", b"Solving real life problems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de1af4b3-38e9-4a3f-b03a-e47417c430e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOV>>(v1);
    }

    // decompiled from Move bytecode v6
}

