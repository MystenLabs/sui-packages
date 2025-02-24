module 0x45342c72f0fdce3e5e4540f855d108d37f123d1e57b3308f83763ae7d9997534::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON>(arg0, 6, b"ELON", b"elon", b"ELON MUSK IS A GOOD MAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elon_Musk_Royal_Society_cropped_332b1610cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

