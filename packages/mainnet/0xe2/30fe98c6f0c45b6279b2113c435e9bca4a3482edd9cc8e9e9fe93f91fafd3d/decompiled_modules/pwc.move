module 0xe230fe98c6f0c45b6279b2113c435e9bca4a3482edd9cc8e9e9fe93f91fafd3d::pwc {
    struct PWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWC>(arg0, 9, b"PWC", b"pepe wif cig", b"https://x.com/elonmusk/status/1935662667492139188", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmWVWBFBkVqXXwNyEjnpHek7BM1mgGkkPiFWbin6Ypvmei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWC>>(v1);
    }

    // decompiled from Move bytecode v6
}

