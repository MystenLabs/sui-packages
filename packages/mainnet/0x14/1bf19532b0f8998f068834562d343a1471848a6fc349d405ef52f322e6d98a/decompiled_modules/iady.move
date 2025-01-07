module 0x141bf19532b0f8998f068834562d343a1471848a6fc349d405ef52f322e6d98a::iady {
    struct IADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IADY>(arg0, 6, b"IADY", b"I AM DAD YOU", b"internet Explorer in the middle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1dfe0c1e0535514b3693827c99810703_baaa57989a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

