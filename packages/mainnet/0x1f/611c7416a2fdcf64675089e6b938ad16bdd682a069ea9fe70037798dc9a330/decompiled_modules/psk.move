module 0x1f611c7416a2fdcf64675089e6b938ad16bdd682a069ea9fe70037798dc9a330::psk {
    struct PSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSK>(arg0, 9, b"PSK", b"Piska", b"Piska coen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2c8cb3b-6df7-4db4-9e81-26eae7dc2018.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

