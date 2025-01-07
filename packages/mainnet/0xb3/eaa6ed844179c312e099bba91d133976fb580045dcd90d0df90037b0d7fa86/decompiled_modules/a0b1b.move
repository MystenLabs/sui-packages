module 0xb3eaa6ed844179c312e099bba91d133976fb580045dcd90d0df90037b0d7fa86::a0b1b {
    struct A0B1B has drop {
        dummy_field: bool,
    }

    fun init(arg0: A0B1B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A0B1B>(arg0, 9, b"A0B1B", b"Abi", b"This is good coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4381b3ae-e340-427e-8bcc-21166719a496.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A0B1B>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A0B1B>>(v1);
    }

    // decompiled from Move bytecode v6
}

