module 0xfee5fb434ba4044d4375126f4541e1ec14aea7db2d21fa2bcb36f50a9f709d7c::ondog {
    struct ONDOG has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"onDOG", b"onDOG", b"Donald J Trump is now on the fastest Blockchain in Crypto Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Flogo_50761c0b8d.png&w=256&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: ONDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<ONDOG>(arg0, arg1);
        0x2::coin::mint_and_transfer<ONDOG>(&mut v0, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

