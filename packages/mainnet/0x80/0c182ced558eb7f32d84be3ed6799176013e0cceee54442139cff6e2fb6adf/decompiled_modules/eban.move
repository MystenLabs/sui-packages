module 0x800c182ced558eb7f32d84be3ed6799176013e0cceee54442139cff6e2fb6adf::eban {
    struct EBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBAN>(arg0, 9, b"EBAN", b"Ebansraj", b"Just Joke Meme, Not Real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7f93425-f63d-4036-92fa-31d1ea6270e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EBAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

