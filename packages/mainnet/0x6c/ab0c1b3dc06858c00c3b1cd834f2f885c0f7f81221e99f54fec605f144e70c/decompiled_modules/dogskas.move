module 0x6cab0c1b3dc06858c00c3b1cd834f2f885c0f7f81221e99f54fec605f144e70c::dogskas {
    struct DOGSKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSKAS>(arg0, 9, b"DOGSKAS", b"Wewe", b"Gi you my tu day not ting ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54ebef03-8f5a-4273-b7d1-66d6488e88d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

