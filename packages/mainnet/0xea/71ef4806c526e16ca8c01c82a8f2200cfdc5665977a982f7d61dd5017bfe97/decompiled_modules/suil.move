module 0xea71ef4806c526e16ca8c01c82a8f2200cfdc5665977a982f7d61dd5017bfe97::suil {
    struct SUIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIL>(arg0, 6, b"SUIL", b"Navy Suil", b"Just a normal SUIL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5969_56e20557ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

