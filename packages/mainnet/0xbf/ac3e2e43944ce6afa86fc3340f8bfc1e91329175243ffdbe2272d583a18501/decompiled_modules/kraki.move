module 0xbfac3e2e43944ce6afa86fc3340f8bfc1e91329175243ffdbe2272d583a18501::kraki {
    struct KRAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAKI>(arg0, 6, b"Kraki", b"Kraki On Sui", x"4b72616b69204f6e2053756920697320746865206e65772066616365206f6e20746865206d61726b65742e0a0a4a6f696e207468652066616d696c79206173204b72616b692063616e20484f444c20612062696720636f6d6d756e697479207769746820686973206d616e792061726d732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif6m7sgtms6pb5o73aylnej3damguzg7bgqufkqdfcc3ev4nsb35u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRAKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

