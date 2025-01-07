module 0xc04bbf45d11ac49a7499cb1f7e91e6687e67bfed5c10e111c80769890c9fed9a::tu {
    struct TU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TU>(arg0, 9, b"TU", b"TRUMP", b"Meme about DonalTrump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44831c1b-29a0-403f-9dea-b4ddbf372629.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TU>>(v1);
    }

    // decompiled from Move bytecode v6
}

