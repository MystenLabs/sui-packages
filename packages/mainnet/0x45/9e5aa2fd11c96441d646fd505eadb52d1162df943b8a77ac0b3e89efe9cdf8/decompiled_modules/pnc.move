module 0x459e5aa2fd11c96441d646fd505eadb52d1162df943b8a77ac0b3e89efe9cdf8::pnc {
    struct PNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNC>(arg0, 6, b"PNC", b"Pokemon NetCoin", b"Fans of Pokemon Unite!!, Just a fan token with no utility. Have fun and enjoy the ride.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000064001_802d08476d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

