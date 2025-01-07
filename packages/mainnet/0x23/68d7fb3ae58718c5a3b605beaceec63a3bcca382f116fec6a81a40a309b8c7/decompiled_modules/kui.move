module 0x2368d7fb3ae58718c5a3b605beaceec63a3bcca382f116fec6a81a40a309b8c7::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUI>(arg0, 6, b"KUI", b"Kirby Sui", b"https://en.m.wikipedia.org/wiki/Kirby_(character)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027958_6bf418ed93.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

