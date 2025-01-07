module 0x8962d95648c44ef84d9b67bdcdb14d5df858d0cea181d8d000afab924388d9e4::bb {
    struct BB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB>(arg0, 9, b"BB", b"Bebong", b"strawberry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/afb59cd9-8447-4ecb-8165-0f4657dd8852.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BB>>(v1);
    }

    // decompiled from Move bytecode v6
}

