module 0xc3aa2df2dcdb272b72233dc72817898c528606d2ac6a23e04381097512e0ccb3::hoodiecat {
    struct HOODIECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOODIECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOODIECAT>(arg0, 9, b"HoodieCat", b"Hoodie Cat", b"Hoodie Cat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOODIECAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOODIECAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOODIECAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

