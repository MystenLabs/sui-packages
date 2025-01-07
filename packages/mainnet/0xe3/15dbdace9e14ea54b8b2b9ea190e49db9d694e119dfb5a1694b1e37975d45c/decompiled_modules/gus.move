module 0xe315dbdace9e14ea54b8b2b9ea190e49db9d694e119dfb5a1694b1e37975d45c::gus {
    struct GUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUS>(arg0, 6, b"GUS", b"Gus Coin", b"Explore the World of GUS. Join GUS as he dives into the exciting world of SUI memecoins and fun challenges!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_65a0adc436.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

