module 0x384b0120d35420d423ff1b3f7db284858588c9547f020ca0f6550f1b12eb0d37::hipo {
    struct HIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPO>(arg0, 9, b"HIPO", b"Hipo", b"hipo go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d503c7e6-1030-40bc-958d-aa546c5ceb36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

