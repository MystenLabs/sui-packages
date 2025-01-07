module 0x8c81a6ddfb1b8c2c193cfb6fe74d58d26dea1767f0bfedfcc0c6a7a862ea1950::flawless {
    struct FLAWLESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAWLESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAWLESS>(arg0, 3, b"FLAWLESS", b"FLAWLESS", b"FLAWLESS is a coin for the FLAWLESS project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/previews/011/947/129/original/gold-internet-icon-free-png.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLAWLESS>>(v1);
        0x2::coin::mint_and_transfer<FLAWLESS>(&mut v2, 900000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAWLESS>>(v2, @0x0);
    }

    public fun transfer_upgrade_cap(arg0: 0x2::package::UpgradeCap, arg1: address) {
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

