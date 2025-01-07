module 0x9b6e26426aad650e55e83fab1de5f178665289babdf500af39b1091f03a4f7c9::babywhaly {
    struct BABYWHALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYWHALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYWHALY>(arg0, 9, b"BABYWHALY", x"f09f908b42616279205768616c79", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYWHALY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYWHALY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYWHALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

