module 0xb13db8ccd4a80220d41d8ee5b1b0bc661873e510b1f8207463f483b227df9e1::scarrot {
    struct SCARROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARROT>(arg0, 9, b"SCARROT", b"Scarrot.MM", b"Vegetable for healthy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b9d77e6-cd86-401a-a990-9e28a26e76a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCARROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

