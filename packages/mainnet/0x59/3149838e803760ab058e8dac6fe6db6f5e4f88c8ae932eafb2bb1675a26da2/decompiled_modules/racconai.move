module 0x593149838e803760ab058e8dac6fe6db6f5e4f88c8ae932eafb2bb1675a26da2::racconai {
    struct RACCONAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACCONAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACCONAI>(arg0, 6, b"RACCONAI", b"RACCON AI", x"526163636f6f6e2061692028526169290a456c6f6e206d75736b20646f6765207472756d70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/64346_5f34108785.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACCONAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACCONAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

