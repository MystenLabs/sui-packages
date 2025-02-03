module 0x43b07ab14c5f3b43ece644f68687cc455595576b627ad41949fe7c2ef9a5f16f::aimovoro {
    struct AIMOVORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIMOVORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIMOVORO>(arg0, 9, b"AIMOVORO", b"AIMOVOROS", b"Crypto Parasite of SUI: A Tiny Leech with the Power to Absorb All Blue Liquid. Beware, Our Entropy is Parasitic!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3339fba1992c9d48248e4d1e2df6232fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIMOVORO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIMOVORO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

