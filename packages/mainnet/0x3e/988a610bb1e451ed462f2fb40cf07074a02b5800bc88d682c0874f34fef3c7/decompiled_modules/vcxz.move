module 0x3e988a610bb1e451ed462f2fb40cf07074a02b5800bc88d682c0874f34fef3c7::vcxz {
    struct VCXZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCXZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCXZ>(arg0, 9, b"VCXZ", b"DF", b"ZCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73e729ba-3c8b-4cc7-a533-1204cae955ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCXZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VCXZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

