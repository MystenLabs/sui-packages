module 0x996a8a1b1ed04fe2304b82fd7ce238d283ac901f1817489fa4b17cebb8b485a4::dsl {
    struct DSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSL>(arg0, 6, b"DSL", b"Dollar Shiba Inu", b"Meme coin, inspired by a Shiba Inu wearing a knitted hat, combines humor and creativity to bring endless possibilities!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241014031848_c7f7bc4975.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

