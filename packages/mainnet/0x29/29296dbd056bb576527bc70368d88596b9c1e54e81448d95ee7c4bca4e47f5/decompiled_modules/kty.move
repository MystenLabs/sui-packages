module 0x2929296dbd056bb576527bc70368d88596b9c1e54e81448d95ee7c4bca4e47f5::kty {
    struct KTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTY>(arg0, 9, b"KTY", b"Kitty ", b"Meme of Cute Kitten ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71ea5145-1f1b-41b5-9c25-bdc046c07147.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

