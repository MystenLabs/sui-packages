module 0x283ddf839153398a545dc9df916b7ed77bb7a3473a873171c0933f4d52344545::tk {
    struct TK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TK>(arg0, 9, b"TK", b"Talk", b"Talk crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4bb56e0b-704d-40d9-a705-e8fab26aac58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TK>>(v1);
    }

    // decompiled from Move bytecode v6
}

