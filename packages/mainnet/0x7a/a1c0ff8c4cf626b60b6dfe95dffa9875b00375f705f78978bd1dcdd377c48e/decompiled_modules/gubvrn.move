module 0x7aa1c0ff8c4cf626b60b6dfe95dffa9875b00375f705f78978bd1dcdd377c48e::gubvrn {
    struct GUBVRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUBVRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUBVRN>(arg0, 9, b"GUBVRN", b"Gubernia", b"Gubernia vrn token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b08c6d2c-b8f9-4287-bcd9-b9ac2ec914cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUBVRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUBVRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

