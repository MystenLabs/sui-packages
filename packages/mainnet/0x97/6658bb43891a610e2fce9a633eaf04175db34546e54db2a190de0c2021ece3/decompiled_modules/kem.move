module 0x976658bb43891a610e2fce9a633eaf04175db34546e54db2a190de0c2021ece3::kem {
    struct KEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEM>(arg0, 9, b"KEM", b"Poodle Dog", b"This is my poodle dog. His name is Kem. He is so cute and active. I live him so much !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50913720-369a-4cfc-83a5-497f0479124f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

