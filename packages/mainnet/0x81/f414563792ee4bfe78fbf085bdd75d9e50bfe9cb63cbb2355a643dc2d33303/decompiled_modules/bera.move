module 0x81f414563792ee4bfe78fbf085bdd75d9e50bfe9cb63cbb2355a643dc2d33303::bera {
    struct BERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERA>(arg0, 6, b"BERA", b"BeraChain2.0", b"1 BERA = 1ETH, you have a trust to hold. You will have assets from berachain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/berafy_image_6_f00bdb0f7e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERA>>(v1);
    }

    // decompiled from Move bytecode v6
}

