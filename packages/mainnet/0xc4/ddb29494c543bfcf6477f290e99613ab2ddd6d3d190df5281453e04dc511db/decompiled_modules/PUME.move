module 0xc4ddb29494c543bfcf6477f290e99613ab2ddd6d3d190df5281453e04dc511db::PUME {
    struct PUME has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PUME>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PUME>>(0x2::coin::mint<PUME>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: PUME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUME>(arg0, 6, b"PUME", b"PUME", b"The PUME Token is a playful, community-driven meme coin on the SUI blockchain, crafted to embody fun, growth, and wealth potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://Qmcxv6UB9eYc1T73nUyz2jw97QiRAR6bnt9mKjdCFPhiGp")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PUME>>(0x2::coin::mint<PUME>(&mut v2, 21000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUME>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUME>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

