module 0x32f1d143ee31c0812d8dfab31025b2695e1cd13e0c1fa94e9e097bbffca56b76::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 6, b"ADA", b"Cardano", b"Cardano is a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/f3eb172b-f76c-42c3-bc1b-eeac57745c90.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

