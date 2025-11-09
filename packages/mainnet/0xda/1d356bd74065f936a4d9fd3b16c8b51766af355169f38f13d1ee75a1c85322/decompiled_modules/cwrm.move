module 0xda1d356bd74065f936a4d9fd3b16c8b51766af355169f38f13d1ee75a1c85322::cwrm {
    struct CWRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWRM>(arg0, 6, b"CWRM", b"CODEWORM", b"The first real CODEWORM-related project is almost ready for production https://udany-urlop.pl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiahngjcdmosdavp3ca5jvdlos5lgzwspmlbpqw53kf54mhpphpjpy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CWRM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

