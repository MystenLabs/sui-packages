module 0xc5006a7d6175a8a6334adcea9ca529768ef9890c4905dfd938f651a623ebf6a5::charmeme {
    struct CHARMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARMEME>(arg0, 9, b"CHARMEME", b"Charmeme", x"4669726520757020796f757220666565642120436861726d656d65207370726561647320766972616c20656e6572677920616e64207761726d2068797065206576657279776865726520697420676f6573e2809463617574696f6e2c206d617920636175736520464f4d4f206275726e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibkrhreefljhi4opyvrxtzxxjjknbrkujg6ccwozfl7f3f6nik444")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHARMEME>(&mut v2, 1000000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARMEME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

