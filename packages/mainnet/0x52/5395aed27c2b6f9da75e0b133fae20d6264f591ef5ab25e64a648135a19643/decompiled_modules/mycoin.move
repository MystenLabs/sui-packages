module 0x525395aed27c2b6f9da75e0b133fae20d6264f591ef5ab25e64a648135a19643::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: 0x2::coin::Coin<MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<MYCOIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::mint<MYCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<MYCOIN>(arg0, 9, b"BOB", b"SPONBOB", x"53504f4e424f4220e2809420d0bcd0b5d0bc2dd182d0bed0bad0b5d0bd2c20d0bcd0b8d0bdd18220d0bad182d0be20d183d0b3d0bed0b4d0bdd0be20d181d0bad0bed0bbd18cd0bad0be20d183d0b3d0bed0b4d0bdd0be21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yt3.googleusercontent.com/ytc/AIdro_kDCVNMLoQMo3Aqa-UDrndrPMzFYVXlHs4H_K_JELyzkg=s900-c-k-c0x00ffffff-no-rj")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<MYCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MYCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

