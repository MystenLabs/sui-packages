module 0x56e2f89a667fce5f2f573b04f881c107e0c891d500a35e414a240af616ced82d::spf {
    struct SPF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPF>(arg0, 9, b"SPF", b"Smiling Pufferfish", b"The fish that keeps on smiling (and swimming)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8YGNACGaFimaFGwfZs5sZFhxrQfxc7F3ZSHKHZvCpump.png?size=xl&key=4c3d37")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPF>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPF>>(v1);
    }

    // decompiled from Move bytecode v6
}

