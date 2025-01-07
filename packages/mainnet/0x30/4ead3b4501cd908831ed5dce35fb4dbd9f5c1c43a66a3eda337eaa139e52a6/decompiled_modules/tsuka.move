module 0x304ead3b4501cd908831ed5dce35fb4dbd9f5c1c43a66a3eda337eaa139e52a6::tsuka {
    struct TSUKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUKA>(arg0, 9, b"TSUKA", b"DejitaruTsuka", x"576520617265206f6e2061206d697373696f6e20746f2061636869657665207472756520646563656e7472616c697a6174696f6e206163636f6d70616e696564206279206d696e6466756c6e65737320262073656c6620496d70726f76656d656e7420f09fa7982068747470733a2f2f7777772e64656a69746172757473756b617375692e66756e2f2068747470733a2f2f742e6d652f64656a69746172757473756b6173756920202068747470733a2f2f782e636f6d2f7473756b616f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1728756355879-0c6311f7119d29c2a9673efcc2f39da1.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSUKA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUKA>>(v2, @0xca255026617212bbf17e6e76e3185529db3a0415d512cf3fa944887b620fb7d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

