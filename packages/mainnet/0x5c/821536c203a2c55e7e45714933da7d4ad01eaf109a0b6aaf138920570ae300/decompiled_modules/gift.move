module 0x5c821536c203a2c55e7e45714933da7d4ad01eaf109a0b6aaf138920570ae300::gift {
    struct GIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIFT>(arg0, 6, b"GIFT", b"Gift", b"You Christmas $GIFT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055093_16bb75158e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

