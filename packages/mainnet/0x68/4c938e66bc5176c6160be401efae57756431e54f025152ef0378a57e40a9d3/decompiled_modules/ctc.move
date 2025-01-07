module 0x684c938e66bc5176c6160be401efae57756431e54f025152ef0378a57e40a9d3::ctc {
    struct CTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTC>(arg0, 9, b"CTC", b"Crazy Tackle", b"A community about the most craziest dog around bringing a smile on everyone's face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.crazyteckel.com/imgs/crazy-teckel-coin.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CTC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTC>>(v2, @0x82313356740e282215c23d4e000e5e50f9447ca8d0a7c0c4436cf4bcfbb6fd9f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

