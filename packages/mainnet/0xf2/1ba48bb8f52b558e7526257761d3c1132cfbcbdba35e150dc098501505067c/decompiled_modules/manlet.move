module 0xf21ba48bb8f52b558e7526257761d3c1132cfbcbdba35e150dc098501505067c::manlet {
    struct MANLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANLET>(arg0, 9, b"MANLET", b"Man knows", b"What do you want to hear?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b35270be-7ea0-482a-977d-296b68aa4dbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

