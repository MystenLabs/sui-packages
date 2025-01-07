module 0xa833aa42a6a42495f86d41b64edd748b6736c640d895ba03b22bef6dcfd57c0c::puffle {
    struct PUFFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFLE>(arg0, 6, b"PUFFLE", b"Puffle", b"Puffle is the latest memecoin launched on the Sui blockchain, blending the world of memes with cutting-edge technology. Built on principles of transparency, security, and sustainability, Puffle offers a new experience for the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986888328.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUFFLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

