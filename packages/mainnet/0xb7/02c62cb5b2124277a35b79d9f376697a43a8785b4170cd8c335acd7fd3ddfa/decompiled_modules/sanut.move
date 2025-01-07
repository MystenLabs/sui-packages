module 0xb702c62cb5b2124277a35b79d9f376697a43a8785b4170cd8c335acd7fd3ddfa::sanut {
    struct SANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANUT>(arg0, 9, b"Sanut", b"Sandy Cheeks", x"53616e6479206973206120736d61727420736369656e746973742077686f206c6f766573206368616c6c656e67696e67206c696d6974732e204174207468652073616d652074696d652c202453616e757420726570726573656e74732074686520667573696f6e206f66206f6365616e20616e64206c616e642063756c74757265732c2073796d626f6c697a696e6720616e20696e766573746d656e7420617070726f61636820746861742062616c616e63657320776973646f6d20616e6420616476656e7475726520696e20746865206d61726b65742e0a0a5468696e6b20736d6172742c20696e7665737420736d61727465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x2ae7a2619b952f36f8ebfb6fa46dc689acfef36d.png?size=xl&key=99d357")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SANUT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANUT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

