module 0xf715846f9c10364798ec08753ae8310f02dacdd0aac2a011c5e2e5e9dc90b736::dxt {
    struct DXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXT>(arg0, 9, b"DXT", b"Dexter", x"6e74726f647563696e672044657874657220436f696e20e280932054686520706c617966756c2c206c6f79616c2c20616e64206c6f7661626c652063727970746f20696e737069726564206279204465787465722c2074686520626c61636b2050756721204a6f696e20746865207061772d736f6d65206a6f75726e657920696e746f2074686520667574757265206f6620646563656e7472616c697a6564206d656d6520776f726c642e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DXT>(&mut v2, 130000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DXT>>(v1);
    }

    // decompiled from Move bytecode v6
}

