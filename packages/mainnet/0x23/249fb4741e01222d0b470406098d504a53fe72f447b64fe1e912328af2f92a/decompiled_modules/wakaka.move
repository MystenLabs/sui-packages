module 0x23249fb4741e01222d0b470406098d504a53fe72f447b64fe1e912328af2f92a::wakaka {
    struct WAKAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAKAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAKAKA>(arg0, 6, b"WAKAKA", b"WAKAKA BIRD", b"Just A Viral Bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0823_1283d29e6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAKAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAKAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

