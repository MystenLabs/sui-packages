module 0x34f65677b586813d20c0b89202e6ec4422794241a2a52e5226ad4f2f71ec2fae::suibulls {
    struct SUIBULLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULLS>(arg0, 9, b"SUIBULLS", b"SUIBULLS", b"SUI BULLS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBULLS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULLS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBULLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

