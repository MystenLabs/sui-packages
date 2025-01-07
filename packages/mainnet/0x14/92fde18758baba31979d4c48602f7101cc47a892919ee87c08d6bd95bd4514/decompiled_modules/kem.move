module 0x1492fde18758baba31979d4c48602f7101cc47a892919ee87c08d6bd95bd4514::kem {
    struct KEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEM>(arg0, 9, b"KEM", b"Poodle Dog", b"This is my poodle dog. His name is Kem. He is so cute and active. I live him so much !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e7c43bc-1f20-4624-af22-e8e8edb009cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

