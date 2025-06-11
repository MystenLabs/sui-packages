module 0xf20ac41ec591066077de524887417d3a4865224c23c065928acea7ae033df6ec::vcry {
    struct VCRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCRY>(arg0, 6, b"VCRY", b"Victory", b"SUI FTW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigxg4ism6yfwt24oyt2qtpqlfvjmpnne2tqaoffxcfcdlnamat4hi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VCRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

