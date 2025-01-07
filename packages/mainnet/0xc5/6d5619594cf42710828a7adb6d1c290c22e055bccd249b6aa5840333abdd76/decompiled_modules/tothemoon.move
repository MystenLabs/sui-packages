module 0xc56d5619594cf42710828a7adb6d1c290c22e055bccd249b6aa5840333abdd76::tothemoon {
    struct TOTHEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTHEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTHEMOON>(arg0, 9, b"TOTHEMOON", b"MOONSUI", b"SUI WILL TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7dd77e80-1218-4a5a-9de0-8cd349f89ef5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTHEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOTHEMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

