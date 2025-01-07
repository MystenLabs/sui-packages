module 0x9d1139c3f8b7a98433098bb4027cc60445a99fb716efaffb3e41489c10b11276::bdmn {
    struct BDMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDMN>(arg0, 9, b"BDMN", b"BIRDMAN", b"BIRDMAN token flying ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ae480da-5374-41b0-93f6-4eaa98cac880.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

