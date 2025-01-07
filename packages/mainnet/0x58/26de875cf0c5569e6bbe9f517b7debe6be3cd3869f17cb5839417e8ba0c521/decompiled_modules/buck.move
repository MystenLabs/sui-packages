module 0x5826de875cf0c5569e6bbe9f517b7debe6be3cd3869f17cb5839417e8ba0c521::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK>(arg0, 9, b"BUCK", b"Bucket Protocol", b"Bucket Protocol aims to be a DeFi Engine on Sui network. It allow users to draw low and predictable interest loans against $SUI $BTC $ETH and LST used as collateral.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Bucket_Protocol_Logo_60d64e5cf5.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUCK>>(0x2::coin::mint<BUCK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUCK>>(v2);
    }

    // decompiled from Move bytecode v6
}

