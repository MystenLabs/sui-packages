module 0x801e8bd5a98a226920f8c64ae7a38282edcf2b293701d055eec17657a6534d10::usdp {
    struct USDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDP>(arg0, 9, b"USDP", b"USDP", b"USDP glasses and wine and cheese for dinner tonight for", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/e-px6R2GfpCBNRx_W3iS2yIB3nf7vVQLrFJsU5eneq0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDP>>(v2, @0x19cb8a3e2d0bdb221d6b0402f5d1c7bedf43efce72229aafd2379e479a8d3f59);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

