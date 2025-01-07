module 0x9ae8a8ffbd00477216b1d443e6b4bfebf64eebd714c24c0dc00cd1165582c0af::petter {
    struct PETTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETTER>(arg0, 6, b"PETTER", b"Petter Coin", b"$PETTER is a revolutionary community driven initiative that leverages the power of blockchain and decentralized technologies to foster positive social impact. The project aims to build a global, inclusive, and collaborative platform where individuals organizations and communities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048174_08f0944a32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

