module 0xce247ce3ce96643766cb898d40f809a98bd4f5fb702831baaad0eca5403a7666::bdg {
    struct BDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDG>(arg0, 6, b"BDG", b"Blue Dot Guy", b"The Blue Dot marks it spot on-chain. Born on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_13_073227_48997e2ddb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

