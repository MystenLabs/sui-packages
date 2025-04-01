module 0x2c5192f18b08f7c8f03df0f845382b14f723dc1dd005edde18592926a4020f65::mu {
    struct MU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MU>(arg0, 6, b"MU", b"MultiUniverse", b"Do you believe MultiUniverse?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.jsdelivr.net/gh/leafwind-web3/image/multiuniverse.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MU>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MU>>(v1);
    }

    // decompiled from Move bytecode v6
}

