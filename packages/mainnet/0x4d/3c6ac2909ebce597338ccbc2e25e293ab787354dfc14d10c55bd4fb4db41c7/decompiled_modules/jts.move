module 0x4d3c6ac2909ebce597338ccbc2e25e293ab787354dfc14d10c55bd4fb4db41c7::jts {
    struct JTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JTS>(arg0, 6, b"JTS", b"Justin SUI", b"This is the first token created to honor Justin SUN on SUI network. I will build a Legacy. Take me to the SUN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_23_at_12_54_29_PM_49b3ed9b97.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

