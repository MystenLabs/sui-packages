module 0xda946b28bb8d660bc0bc82a8ad14041899fc39ac88808154fc66232aa23bc54a::fishtoken {
    struct FISHTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHTOKEN>(arg0, 9, b"FISHTOKEN", b"Fish", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dafb0366-1607-4ad6-a169-28d93b71e89d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

