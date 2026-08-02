module 0xc363e34f60af17ce651ac96adeb96be93748a9109797bd246186be7145cade95::Cat_Token {
    struct CAT_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT_TOKEN>(arg0, 9, b"CATT", b"Cat Token", b"Token Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3.coinmarketcap.com/static-gravity/image/7d04b329239e487cb8ea865ec5c2b7a1.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAT_TOKEN>(&mut v2, 1000 * 0x1::u64::pow(10, 9), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

