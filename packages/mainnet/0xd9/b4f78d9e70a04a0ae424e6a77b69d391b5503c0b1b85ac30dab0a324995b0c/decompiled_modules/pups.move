module 0xd9b4f78d9e70a04a0ae424e6a77b69d391b5503c0b1b85ac30dab0a324995b0c::pups {
    struct PUPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPS>(arg0, 9, b"PUPS", x"50555053e280a2574f524c44e280a25045414345", b"$PUPS : spreading world peace", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ebdb342951c04489a5d279df3243a3a1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

