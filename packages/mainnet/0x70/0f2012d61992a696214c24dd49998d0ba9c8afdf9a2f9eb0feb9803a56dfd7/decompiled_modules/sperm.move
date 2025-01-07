module 0x700f2012d61992a696214c24dd49998d0ba9c8afdf9a2f9eb0feb9803a56dfd7::sperm {
    struct SPERM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPERM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPERM>(arg0, 6, b"SPERM", b"SUI SPERM", b"Sui sperm is one horny character of the ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sperm_e272a798d2.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPERM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPERM>>(v1);
    }

    // decompiled from Move bytecode v6
}

