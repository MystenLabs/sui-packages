module 0x4d914f2f5b67d5448c5a333ab1a893d5e5b05a39c06e6c16c8704a0e3a0d3483::puffle {
    struct PUFFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFLE>(arg0, 6, b"Puffle", b"PUFFLE", b"Puffle is the latest memecoin launched on the Sui blockchain, blending the world of memes with cutting-edge technology. Built on principles of transparency, security, and sustainability, Puffle offers a new experience for the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241019_111735_a23ae7cafe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

