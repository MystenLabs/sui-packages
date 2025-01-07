module 0xae4eb16a1570a1a2f53073bac70bdd5ac437c289653d691f0194719e88a18556::hangyodon {
    struct HANGYODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANGYODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANGYODON>(arg0, 6, b"HANGYODON", b"Hangyodon-CTO", b"Dev just betrayed us, the community will seek revenge and elevate Hangyodon to the top.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6077900781866040637_c_91beb96ee2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANGYODON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANGYODON>>(v1);
    }

    // decompiled from Move bytecode v6
}

