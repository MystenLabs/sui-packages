module 0xc23104540a9dd015311db5f3f5233976ddd234360fcc57a2e17f2824d55f76a2::weee {
    struct WEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEE>(arg0, 9, b"WEEE", b"Weeders", b"A token to legalize marijuana across the globe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/439570d5-fd72-4c28-a930-321a40bec9a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

