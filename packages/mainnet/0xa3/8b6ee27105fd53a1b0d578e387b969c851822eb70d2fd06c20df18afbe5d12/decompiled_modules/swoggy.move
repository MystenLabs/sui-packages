module 0xa38b6ee27105fd53a1b0d578e387b969c851822eb70d2fd06c20df18afbe5d12::swoggy {
    struct SWOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOGGY>(arg0, 6, b"SWOGGY", b"SWOG-2", b"The biggest smile on the planet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_355c718ca6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

