module 0x184d9efb34085d86d802736bb9747ed6844eb66f036042578df1852c39a992c9::sblowfish {
    struct SBLOWFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLOWFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLOWFISH>(arg0, 6, b"Sblowfish", b"SUIBlow", x"5468652043727970746f20546861747320526561647920746f20426c6f7720557021200a496e74726f647563696e6720535549626c6f772c20746865206d656d6520636f696e207769746820612062696720617474697475646520616e64206576656e2062696767657220706f74656e7469616c21204a757374206c696b652074686520707566666572666973682c20535549626c6f77206d617920737461727420736d616c6c2c20627574207768656e207468652074696d6520636f6d65732c20697420626c6f777320757020696e206120626967207761792120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_cute_meme_blow_fis_1fddb4b51a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLOWFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLOWFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

