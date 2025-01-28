module 0x39e7eb9a5d35004583d0110f3ea2837e623c33abdf3e690e0555aaa005ce8d6f::billysui {
    struct BILLYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLYSUI>(arg0, 9, b"BillySui", b"Shibetoshi Nakamoto On Sui", x"7468652064756d626173732077686f206d61646520646f6765636f696e0d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfKZYcPqP3EHubZDKQ448C3Sx7sfVWovDh3EPMUdkiU7o")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BILLYSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILLYSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLYSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

