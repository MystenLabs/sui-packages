module 0x3031a7225e811d480519bfb4369f33069b46aa6190026d029fda2c86582caad8::hksui {
    struct HKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKSUI>(arg0, 9, b"HKSUI", b"HONG KONG SUI", b"HONG KONG SUI No.! SUPER CRYPTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmUaQao8R9eYg71PsgWdy9v36VYC9wf2UwkP4WBzJRG89j")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HKSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

