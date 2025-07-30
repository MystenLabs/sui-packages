module 0xb7c3bf4d69f2c1c2ba5fa3d82793df1905bdb78ca236e1ec1eda5d792c8510fd::PSMIL {
    struct PSMIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSMIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSMIL>(arg0, 6, b"Potato Smile", b"PSMIL", b"A meme coin celebrating the joy of potatoes with a smile! PSMIL is all about spreading happiness, one potato at a time. Whether boiled, mashed, or fried, every potato deserves to smile. Join the spud-tacular revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/BGhoyFxICOrcK9qMZxpTREALEW2n8Ur0GYv98fEEgMexzfLqA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSMIL>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSMIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

