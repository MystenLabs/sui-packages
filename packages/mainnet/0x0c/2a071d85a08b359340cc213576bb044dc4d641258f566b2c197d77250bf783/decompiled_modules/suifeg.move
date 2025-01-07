module 0xc2a071d85a08b359340cc213576bb044dc4d641258f566b2c197d77250bf783::suifeg {
    struct SUIFEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFEG>(arg0, 6, b"SUIFEG", b"SUI FEG", b"The Mighty FEG is back on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009763_4fb28b1f18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

