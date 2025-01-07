module 0xcb3afee58f74cf4a3f08dc23a33b11c0f20324445910dd5951f9010f4356bb13::pps {
    struct PPS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PPS>, arg1: 0x2::coin::Coin<PPS>) {
        0x2::coin::burn<PPS>(arg0, arg1);
    }

    fun init(arg0: PPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPS>(arg0, 3, b"PPS", b"PetPals Token", b"PetPals Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbwHuBmb5y9RFMTa938vVFebaxTozCGvjuv9w3sUsba2Z")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPS>>(v1);
        0x2::coin::mint_and_transfer<PPS>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPS>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PPS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PPS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

