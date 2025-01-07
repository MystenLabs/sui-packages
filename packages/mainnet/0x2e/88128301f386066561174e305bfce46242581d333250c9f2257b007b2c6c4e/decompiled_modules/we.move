module 0x2e88128301f386066561174e305bfce46242581d333250c9f2257b007b2c6c4e::we {
    struct WE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WE>(arg0, 9, b"WE", b"MUSHLO", b"MUSHLO is a meme inspired by the spirit of adventure and freedom. With WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fd7bfeb-048e-4740-8978-188f16ab9bef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WE>>(v1);
    }

    // decompiled from Move bytecode v6
}

