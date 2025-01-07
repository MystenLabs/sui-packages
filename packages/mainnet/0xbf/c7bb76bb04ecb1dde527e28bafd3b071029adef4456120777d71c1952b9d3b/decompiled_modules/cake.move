module 0xbfc7bb76bb04ecb1dde527e28bafd3b071029adef4456120777d71c1952b9d3b::cake {
    struct CAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAKE>(arg0, 9, b"CAKE", b"cupcake", b"A fun and whimsical cryptocurrency inspired by the sweetness and fun of cakes, featuring an attractive cupcake-themed brand, delightful stories about different cake flavors and recipes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6a51e12-f207-47d9-83a2-22188b34b64f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

