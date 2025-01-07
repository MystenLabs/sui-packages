module 0xb083eacc7181cc10e7bd962cfa2a5129b0c2563abe55f0cf4393cec996ed2a5c::kikosa {
    struct KIKOSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKOSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKOSA>(arg0, 6, b"KikoSa", b"KIKO", b"Kabuso's owner's mom's new family member", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_13_04_54_23_0af75c3d9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKOSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIKOSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

