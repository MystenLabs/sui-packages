module 0x7d83c50573954d63f18710db96f53c79fb6a178f677cad23cac9ec978704c67a::black {
    struct BLACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACK>(arg0, 9, b"BLACK", b"Black", b"BLACK Patter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d12eefac-86c4-44f7-b496-904e067991f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

