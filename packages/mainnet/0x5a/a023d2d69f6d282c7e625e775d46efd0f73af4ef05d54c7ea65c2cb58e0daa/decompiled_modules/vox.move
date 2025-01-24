module 0x5aa023d2d69f6d282c7e625e775d46efd0f73af4ef05d54c7ea65c2cb58e0daa::vox {
    struct VOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOX>(arg0, 6, b"VOX", b"VOX", b"VOX ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/w-L4xIURDFCihY1jB4TYOWVQXOZH9043pQY6PtO-ODE")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VOX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

