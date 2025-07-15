module 0xa90ef70d44d381af7b5fd79bb5a6580a71b68bda7345b5b7bb00e85168e38b2b::bit {
    struct BIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIT>(arg0, 6, b"BIT", b"AMERICAN BITCOIN US", b"AMERICAN BITCOIN SP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752585433268.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

