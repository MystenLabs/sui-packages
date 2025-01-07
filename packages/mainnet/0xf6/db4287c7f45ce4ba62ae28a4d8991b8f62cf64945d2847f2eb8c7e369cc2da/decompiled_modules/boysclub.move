module 0xf6db4287c7f45ce4ba62ae28a4d8991b8f62cf64945d2847f2eb8c7e369cc2da::boysclub {
    struct BOYSCLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYSCLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYSCLUB>(arg0, 9, b"BOYSCLUB", b"Boys Club On Sui", b"Boys Club On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1844099841548484610/dHEuBLNq_400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOYSCLUB>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOYSCLUB>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYSCLUB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

