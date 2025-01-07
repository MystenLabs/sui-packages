module 0x7ba921bc39caf6f3b8c34e73317be1ae26e65d8a515236369d51e26dff4797a4::suielgato {
    struct SUIELGATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIELGATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIELGATO>(arg0, 9, b"SUIELGATO", b"Suielgato", x"535549454c4741544f2c2074686520696e7465726e6574e2809973206661766f7269746520626c7565206361742c206861732061727269766564206f6e207468652053756920626c6f636b636861696e21202f2f2068747470733a2f2f742e6d652f737569656c6761746f706f7274616c202f2f2068747470733a2f2f7777772e737569656c6761746f2e66756e2f20202f2f2068747470733a2f2f782e636f6d2f737569656c6761746f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1728840590296-8dd5f949fc98ddaaf106d0225079266a.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIELGATO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIELGATO>>(v2, @0x516015c12c7f5f61ba18fc6c71d01a1cdc21f193609b6571043b61a113dd3ddd);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIELGATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

