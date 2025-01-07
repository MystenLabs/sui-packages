module 0x5543993c311e6ba07d06fd80aefbe71b6d56dc9e97430e5e89d2262c70013363::sloopy {
    struct SLOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOOPY>(arg0, 6, b"SLOOPY", b"SUI LOOPY", b"We can do it because we are cute! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x9b9c0e26a8ace7edb8fce14acd81507c507c677a400cfb9cc9a0ca4a8432a97a_loopy_sui_loopy_sui_ec59bc3cfb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

