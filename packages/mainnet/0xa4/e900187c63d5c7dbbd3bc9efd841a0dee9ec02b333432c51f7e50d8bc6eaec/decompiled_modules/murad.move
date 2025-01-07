module 0xa4e900187c63d5c7dbbd3bc9efd841a0dee9ec02b333432c51f7e50d8bc6eaec::murad {
    struct MURAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURAD>(arg0, 6, b"Murad", b"MuradOnSui", b"Murad Token is just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001323945_72a6b7eadf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

