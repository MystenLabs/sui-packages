module 0x803ad2202c7a33535c5475830335c501ee26e0ba355d32da5b3b68a36872802f::brl {
    struct BRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRL>(arg0, 9, b"BRL", b"Barrelfc", b"a meme is a real fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2c863af561a1557b82ad8c8db3cf5a39blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

