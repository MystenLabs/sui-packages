module 0xe9a0a9a434c773d62ed35460d4404cc67bf72dd42b56146dab4a3009c6af70c3::pom {
    struct POM has drop {
        dummy_field: bool,
    }

    fun init(arg0: POM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POM>(arg0, 6, b"POM", b"Pom", b"POM - Get ready to bark your way to the topthe future is fluffy, And its filled with endless possibilities!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022499_2329c15af1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POM>>(v1);
    }

    // decompiled from Move bytecode v6
}

