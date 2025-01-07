module 0x28853617a50f6983bf9bcbb5a16ecdd73044315da848a36577ec86fd69309dd7::naruto {
    struct NARUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NARUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NARUTO>(arg0, 9, b"NARUTO", b"NANA", b"NOTHING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3161f4b1-fe33-4eac-ba3e-dcfac35a9d37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NARUTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NARUTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

