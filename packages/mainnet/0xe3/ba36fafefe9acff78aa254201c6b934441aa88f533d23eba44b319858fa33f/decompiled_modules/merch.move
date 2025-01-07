module 0xe3ba36fafefe9acff78aa254201c6b934441aa88f533d23eba44b319858fa33f::merch {
    struct MERCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERCH>(arg0, 6, b"Merch", b"Merch Coin", b"First merch marketplace based on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_6fb5f87b68.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

