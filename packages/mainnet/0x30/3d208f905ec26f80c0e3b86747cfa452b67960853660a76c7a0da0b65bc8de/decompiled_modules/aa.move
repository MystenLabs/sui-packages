module 0x303d208f905ec26f80c0e3b86747cfa452b67960853660a76c7a0da0b65bc8de::aa {
    struct AA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AA>(arg0, 9, b"AA", b"Airbag ", b"Floating meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85975f28-b90f-4448-9603-be1aa4bf3f0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AA>>(v1);
    }

    // decompiled from Move bytecode v6
}

