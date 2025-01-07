module 0x5a07bdd58e7a13baee67ba939c6348751b12441a8283d93a7e8e42b5851294ff::ade3 {
    struct ADE3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADE3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADE3>(arg0, 9, b"ADE3", b"Ade9313", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d88ee4ac-d8d2-4fc3-9b23-6ddc1337423e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADE3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADE3>>(v1);
    }

    // decompiled from Move bytecode v6
}

