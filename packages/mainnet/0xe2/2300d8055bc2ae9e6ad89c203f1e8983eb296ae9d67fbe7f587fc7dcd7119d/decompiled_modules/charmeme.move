module 0xe22300d8055bc2ae9e6ad89c203f1e8983eb296ae9d67fbe7f587fc7dcd7119d::charmeme {
    struct CHARMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARMEME>(arg0, 9, b"CHARMEME", b"Charmeme", x"4669726520757020796f757220666565642120436861726d656d65207370726561647320766972616c20656e6572677920616e64207761726d2068797065206576657279776865726520697420676f6573e2809463617574696f6e2c206d617920636175736520464f4d4f206275726e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibkrhreefljhi4opyvrxtzxxjjknbrkujg6ccwozfl7f3f6nik444")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHARMEME>(&mut v2, 1000000000000000000, @0x72c767ff9daadbf73e24475876ba497a7bc211f59e49cc673f495dd24420383b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARMEME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

