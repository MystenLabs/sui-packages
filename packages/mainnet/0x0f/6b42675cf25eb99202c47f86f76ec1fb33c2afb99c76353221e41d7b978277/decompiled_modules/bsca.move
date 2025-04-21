module 0xf6b42675cf25eb99202c47f86f76ec1fb33c2afb99c76353221e41d7b978277::bsca {
    struct BSCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSCA>(arg0, 6, b"BSCA", b"BSCA", b"1111111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/1KUoqw7X0-dmmhCtDAeG3U8MKPG0l-X29uo-PMifhOs")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BSCA>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSCA>>(v2, @0x4a338f2b4d361f6629755e980464d4aecede4e9ae34bad5e0fad83dbafa30059);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

