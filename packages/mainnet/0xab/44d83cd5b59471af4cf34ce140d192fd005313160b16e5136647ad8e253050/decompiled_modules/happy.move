module 0xab44d83cd5b59471af4cf34ce140d192fd005313160b16e5136647ad8e253050::happy {
    struct HAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPY>(arg0, 9, b"HAPPY", b"HAPPY", b"HAPPYHAPPY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bulltrend-images.s3.amazonaws.com/images/08882cec2ed37fa1f78dbde233ffd3d8d6751ff51360556e9616bb0fec81db73")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAPPY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPY>>(v2, @0xc06167f2c4052b864af9e28fb77c9a8802b2049cc2dacaaf64d7854885d08a68);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

