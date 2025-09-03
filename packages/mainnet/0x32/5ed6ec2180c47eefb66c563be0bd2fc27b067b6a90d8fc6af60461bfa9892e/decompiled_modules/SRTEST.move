module 0x325ed6ec2180c47eefb66c563be0bd2fc27b067b6a90d8fc6af60461bfa9892e::SRTEST {
    struct SRTEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SRTEST>, arg1: 0x2::coin::Coin<SRTEST>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SRTEST>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SRTEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SRTEST>>(0x2::coin::mint<SRTEST>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<SRTEST>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SRTEST>>(arg0);
    }

    fun init(arg0: SRTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRTEST>(arg0, 9, b"SRTEST", b"SUI REAL TEST", b"Testing coin creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dictionary.com/e/wp-content/uploads/2018/03/asdfmovie-300x300.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

