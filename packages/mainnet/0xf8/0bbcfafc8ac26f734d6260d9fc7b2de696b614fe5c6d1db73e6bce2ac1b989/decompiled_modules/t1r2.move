module 0xf80bbcfafc8ac26f734d6260d9fc7b2de696b614fe5c6d1db73e6bce2ac1b989::t1r2 {
    struct T1R2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T1R2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T1R2>(arg0, 9, b"T1R2", b"Truck", b"Truck drivers token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/afad0d9b-3fd0-4347-aa7b-c6a9be127e3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T1R2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T1R2>>(v1);
    }

    // decompiled from Move bytecode v6
}

