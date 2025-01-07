module 0xd2eb07eb6c5593292868b21b84c8e69066f07eac01f08b593ed0a34f2360a680::suipl {
    struct SUIPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPL>(arg0, 9, b"SUIPL", b"Sui liquid points", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"points")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPL>(&mut v2, 11111111000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

