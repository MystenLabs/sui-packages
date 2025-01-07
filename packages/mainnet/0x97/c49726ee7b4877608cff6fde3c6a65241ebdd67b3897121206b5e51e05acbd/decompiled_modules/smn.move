module 0x97c49726ee7b4877608cff6fde3c6a65241ebdd67b3897121206b5e51e05acbd::smn {
    struct SMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMN>(arg0, 9, b"SMN", b"moonsun", x"42726967687420616e6420706f77657266756c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e81d5fb-5ea9-4b69-bd23-1f75aee60206.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

