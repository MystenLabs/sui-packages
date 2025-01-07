module 0x71c67ba5d83905fc68ecdb12cde847fa681956c1d7e3503afad10b182dc632ee::lax3 {
    struct LAX3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAX3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAX3>(arg0, 9, b"LAX3", b"Lax AU", b"Make better speed to internet with AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19571f12-e255-4492-a31b-f829048e9a9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAX3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAX3>>(v1);
    }

    // decompiled from Move bytecode v6
}

