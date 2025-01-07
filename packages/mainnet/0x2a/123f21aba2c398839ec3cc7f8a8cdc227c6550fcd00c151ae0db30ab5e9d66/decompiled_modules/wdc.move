module 0x2a123f21aba2c398839ec3cc7f8a8cdc227c6550fcd00c151ae0db30ab5e9d66::wdc {
    struct WDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDC>(arg0, 9, b"WDC", b"Water Droplet Coin", b"At WDC we love plants, the main image of our coin is a succulent with a water droplet on it's leaves, and a coin with a plant logo on it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://copilot.microsoft.com/images/create/waterplantcoin-with-a-water-droplet-on-an-agave-le/1-6625cb14882e4fd2948fb66a44921bed?id=2R8FxvXK9RNUA%2BQTYzkqAA%3D%3D&view=detailv2&idpp=genimg&idpclose=1&thId=OIG2.F6Efg0bp7T9IKoXpUx8N&lng=en-US&ineditshare=1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WDC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDC>>(v2, @0xb12f533d4ec08345b99d96a5e37787ed5510b38fe66a70525aae8bf47e201a0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

