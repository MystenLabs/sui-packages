module 0x273e068c61362e1bbe168eda99cc95b52e099558fdd04dc2a3c7c2994f7c874f::tom {
    struct TOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOM>(arg0, 9, b"TOM", b"Tom World ", b"Tom World is a meme token, which is represented by Tom community. The old friend (tom and jerry).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/589fe1af-fd79-481a-aa79-7d4d7ca3920e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

