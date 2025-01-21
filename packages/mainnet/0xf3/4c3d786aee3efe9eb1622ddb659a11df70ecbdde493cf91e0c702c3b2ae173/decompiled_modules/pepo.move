module 0xf34c3d786aee3efe9eb1622ddb659a11df70ecbdde493cf91e0c702c3b2ae173::pepo {
    struct PEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPO>(arg0, 9, b"PEPO", b"Pepper & Poppi", b"welcome to the $PEPO community! Pepper & Poppi is the first ever original crypto meme comic book! Together Pepper & Poppi escape the matrix & are on an adventure through the crypto-verse, making new friends along the way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0xdf47789b188a42792e3cccf8cc39fd9fe183a32b.png?size=xl&key=b93179")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

