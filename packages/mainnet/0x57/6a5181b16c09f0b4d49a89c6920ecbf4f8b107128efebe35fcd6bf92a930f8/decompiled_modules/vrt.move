module 0x576a5181b16c09f0b4d49a89c6920ecbf4f8b107128efebe35fcd6bf92a930f8::vrt {
    struct VRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VRT>(arg0, 6, b"VRT", b"Variety AI", b"A research-focused platform that blends AI based predictions with betting mechanics, where mathematical analysis meets real-world forecasting.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihmwbf2j7de4nnat3vhpcvgrywbwvaaojtrhyybanq43bjejpkki4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VRT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

