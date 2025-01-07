module 0x6e7af187a8dd037edc1ac32ac6b6865c5bfc9077eb349a4181713166078d95d5::hex {
    struct HEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEX>(arg0, 6, b"HEX", b"HexedLand web3 RPG", b"HexedLand is a decentralized 1-bit open world action RPG on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_4_5a433e9604_43991d8599.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

