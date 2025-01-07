module 0x5b5c8c49b67cd81edcdd9080292f6b747962579863a3c7b357adb477b9f2fdfb::snc {
    struct SNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNC>(arg0, 9, b"SNC", b"SONIC COIN", x"f09f9a802057656c636f6d6520746f20536f6e6963436f696e20e28093205468652046617374657374204d656d6520436f696e206f6e207468652053756920426c6f636b636861696e2120e29aa1efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169618194?s=400&u=bcf204408d9c5fb5066c370237092129351aa6af&v=4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

