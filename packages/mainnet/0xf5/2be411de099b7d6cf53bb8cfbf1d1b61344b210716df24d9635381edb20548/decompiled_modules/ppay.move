module 0xf52be411de099b7d6cf53bb8cfbf1d1b61344b210716df24d9635381edb20548::ppay {
    struct PPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPAY>(arg0, 6, b"Ppay", b"Pear Pay", b"fast p2p payments", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arivmarketplace.sirv.com/Restaurant%20Images/pearpay.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PPAY>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPAY>>(v2, @0xff11875fb9ab0cf35c0bc5257dcc1b9f7c967d6b2938dd27c4122ee356a8566d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

