module 0xad305d6488121d6b1fce381427a4249304dff912ada6918bf29650065edffa12::ghfjhg {
    struct GHFJHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHFJHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHFJHG>(arg0, 9, b"GHFJHG", b"ASDFA", b"FGHJ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2c7764d-7ce7-4649-8ca3-288529a42622.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHFJHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHFJHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

