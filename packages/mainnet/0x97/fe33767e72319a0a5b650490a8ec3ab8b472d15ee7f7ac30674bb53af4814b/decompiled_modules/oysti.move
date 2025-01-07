module 0x97fe33767e72319a0a5b650490a8ec3ab8b472d15ee7f7ac30674bb53af4814b::oysti {
    struct OYSTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OYSTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OYSTI>(arg0, 9, b"OYSTI", x"f09fa6aa4f79737469", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OYSTI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OYSTI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OYSTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

