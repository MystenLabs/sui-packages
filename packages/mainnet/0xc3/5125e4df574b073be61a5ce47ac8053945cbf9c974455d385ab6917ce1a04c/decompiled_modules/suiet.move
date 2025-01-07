module 0xc35125e4df574b073be61a5ce47ac8053945cbf9c974455d385ab6917ce1a04c::suiet {
    struct SUIET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIET>(arg0, 6, b"SUIET", b"SUIET COIN", b"The Sweetest  Memecoin on #SUI Join the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIT_731b2e512b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIET>>(v1);
    }

    // decompiled from Move bytecode v6
}

