module 0xd38b6d8836067c2906173f258dbb3dee244f7379ddea0617ed3fd3897c3d4fd1::b_boatkid {
    struct B_BOATKID has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BOATKID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BOATKID>(arg0, 9, b"bBOATKID", b"bToken BOATKID", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BOATKID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BOATKID>>(v1);
    }

    // decompiled from Move bytecode v6
}

