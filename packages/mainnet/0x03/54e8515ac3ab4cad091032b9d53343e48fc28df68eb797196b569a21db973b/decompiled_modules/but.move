module 0x354e8515ac3ab4cad091032b9d53343e48fc28df68eb797196b569a21db973b::but {
    struct BUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUT>(arg0, 9, b"BUT", b"Bucket Protocol", b"Bucket Protocol aims to be a DeFi Engine on Sui network. It allow users to draw low and predictable interest loans against $SUI $BTC $ETH and LST used as collateral.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Bucket_Protocol_Logo_60d64e5cf5.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUT>>(0x2::coin::mint<BUT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUT>>(v2);
    }

    // decompiled from Move bytecode v6
}

