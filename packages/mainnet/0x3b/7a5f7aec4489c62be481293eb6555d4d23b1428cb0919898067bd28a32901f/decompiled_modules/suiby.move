module 0x3b7a5f7aec4489c62be481293eb6555d4d23b1428cb0919898067bd28a32901f::suiby {
    struct SUIBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBY>(arg0, 2, b"SUIBY", b"SCOOBY-SUI", b"Suiby ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/2ZZV1l4.jpeg")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIBY>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

