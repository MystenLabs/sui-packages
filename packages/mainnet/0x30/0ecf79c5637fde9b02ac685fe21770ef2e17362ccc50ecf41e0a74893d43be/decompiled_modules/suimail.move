module 0x300ecf79c5637fde9b02ac685fe21770ef2e17362ccc50ecf41e0a74893d43be::suimail {
    struct SUIMAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAIL>(arg0, 9, b"SUIMAIL", b"SUIMAIL", b"SUIMAIL Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMAIL>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAIL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

