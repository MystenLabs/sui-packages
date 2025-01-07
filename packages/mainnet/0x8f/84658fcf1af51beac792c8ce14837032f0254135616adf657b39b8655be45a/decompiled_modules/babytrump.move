module 0x8f84658fcf1af51beac792c8ce14837032f0254135616adf657b39b8655be45a::babytrump {
    struct BABYTRUMP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BABYTRUMP>, arg1: 0x2::coin::Coin<BABYTRUMP>) {
        0x2::coin::burn<BABYTRUMP>(arg0, arg1);
    }

    fun init(arg0: BABYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTRUMP>(arg0, 9, b"Baby Trump", b"BabyTrump", x"426162795472756d70206973206120636f6d6d756e697479206d61646520616e64206f776e65642070726f6a6563742074686174e2809973207374726976696e6720746f206d616b65205472756d702070726f7564206279206265636f6d696e67206120686f757365686f6c64206e616d6520696e207468652043727970746f20737061636521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.trumpsbaby.com/images/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYTRUMP>(&mut v2, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTRUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABYTRUMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BABYTRUMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

