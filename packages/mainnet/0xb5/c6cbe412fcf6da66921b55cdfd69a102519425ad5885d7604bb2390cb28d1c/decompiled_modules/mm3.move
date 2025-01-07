module 0xb5c6cbe412fcf6da66921b55cdfd69a102519425ad5885d7604bb2390cb28d1c::mm3 {
    struct MM3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM3>(arg0, 9, b"MM3", b"Meme 3", b"MM3, Meme 3, mm3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d20736af-5ffd-48e1-9b8b-0cece5fdb119.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MM3>>(v1);
    }

    // decompiled from Move bytecode v6
}

