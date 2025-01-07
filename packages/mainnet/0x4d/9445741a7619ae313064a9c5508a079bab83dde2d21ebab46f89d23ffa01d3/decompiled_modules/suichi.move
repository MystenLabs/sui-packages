module 0x4d9445741a7619ae313064a9c5508a079bab83dde2d21ebab46f89d23ffa01d3::suichi {
    struct SUICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHI>(arg0, 6, b"SUIchi", b"Suichi", b"Michi, but on Sui. The cat still stands on bidness, now in parallel. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_4159_88cc66e335.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

