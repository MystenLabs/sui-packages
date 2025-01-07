module 0xf2a8358eab94876fb66cb68f4bc53d5f6d096d7a400615bd1546b6a2c75d27b6::ashmore_and_cartier_islands {
    struct ASHMORE_AND_CARTIER_ISLANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHMORE_AND_CARTIER_ISLANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHMORE_AND_CARTIER_ISLANDS>(arg0, 2, b"Ashmore and Cartier Islands", b"Ashmore and Cartier Islands", b"Ashmore and Cartier Islands will be FREE. Ashmore and Cartier Islands will WIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASHMORE_AND_CARTIER_ISLANDS>(&mut v2, 333333333333333300, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHMORE_AND_CARTIER_ISLANDS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASHMORE_AND_CARTIER_ISLANDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

