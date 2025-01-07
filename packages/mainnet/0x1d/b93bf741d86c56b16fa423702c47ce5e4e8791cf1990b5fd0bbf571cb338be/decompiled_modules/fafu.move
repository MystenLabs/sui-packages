module 0x1db93bf741d86c56b16fa423702c47ce5e4e8791cf1990b5fd0bbf571cb338be::fafu {
    struct FAFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAFU>(arg0, 9, b"FAFU", b"Fafafufu", b"www.fafafufu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/240c8c82-25e5-4035-a1ec-55ceace3074a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

