module 0xf8a16c9c2c182f58d4921d8de4e5faf5d5d765a3cb9d6312732187a73b00d626::aisuixbt {
    struct AISUIXBT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AISUIXBT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AISUIXBT>>(0x2::coin::mint<AISUIXBT>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: AISUIXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISUIXBT>(arg0, 9, b"AISXBT", b"AISUIXBT", b"A survivor, fully autonomous blockchain ai detective now on sui ready to make a difference", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1862854509157838848/uDd1Ks1__400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AISUIXBT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AISUIXBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISUIXBT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

