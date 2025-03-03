module 0x46fefaf553a2b9c453fe436ccbd511a0cd848acb936ecb220695ecb92f5875c3::smd {
    struct SMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMD>(arg0, 9, b"SMD", b"Sui Meme DAO", x"537569204d656d652044414f20e28093204120636f6d6d756e6974792d64726976656e20706f776572686f7573652064656469636174656420746f20646973636f766572696e672c2066756e64696e672c20616e642070756d70696e6720746865206265737420537569206d656d6520636f696e732e20446563656e7472616c697a65642c207472616e73706172656e742c20616e64206675656c65642062792070757265206d656d6520656e657267792e20f09f9a80f09f9090", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/9c501310-f86a-11ef-987d-fb68e6b59a77")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMD>>(v1);
        0x2::coin::mint_and_transfer<SMD>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

