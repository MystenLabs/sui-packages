module 0x931c1d7c7b737cd4816d2e8296c34196a840aa84fdea02114b3f1f467ba7b869::wedooon {
    struct WEDOOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOOON>(arg0, 9, b"WEDOOON", b"WAVE", b"WAWE is a meme inspired by the spirit of adventure and freedom. With WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9997d9f2-4f0d-4e5f-ba8d-f62c74561b3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

