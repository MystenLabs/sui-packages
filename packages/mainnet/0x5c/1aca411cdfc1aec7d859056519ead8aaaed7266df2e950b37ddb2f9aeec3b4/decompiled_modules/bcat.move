module 0x5c1aca411cdfc1aec7d859056519ead8aaaed7266df2e950b37ddb2f9aeec3b4::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAT>(arg0, 6, b"BCAT", b"Bear Cat", b"Bear Cat ($BCAT) is the purr-fect blend of cuteness and power. Representing the fearless spirit of a bear and the playful charm of a cat, this memecoin is here to dominate the crypto jungle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732059975109.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

