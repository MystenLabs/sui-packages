module 0xd668bf10b60ec9694b7cc8f6ccd52dc32f50d4bc53973c9baf7e41f34854fd5::tub {
    struct TUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUB>(arg0, 6, b"TUB", b"Sui Bathtub", x"54686520436c65616e657374204d656d6520436f696e206f6e205375690a57656c636f6d6520746f2053554920424154485455422c2074686520756c74696d61746520736f616b207a6f6e6520666f7220646567656e732c20647265616d6572732c20616e64206d656d652062656c696576657273206f6e207468652053756920626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicyi4i6cp2hga7e2ukc7lrvcpv43w2ll2vr6qayaix4uvfzjrsbgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

