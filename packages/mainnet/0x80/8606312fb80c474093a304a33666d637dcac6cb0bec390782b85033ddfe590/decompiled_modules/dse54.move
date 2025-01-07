module 0x808606312fb80c474093a304a33666d637dcac6cb0bec390782b85033ddfe590::dse54 {
    struct DSE54 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSE54, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSE54>(arg0, 6, b"DSE54", b"Drafihnb", b"rees", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cheems_meme_1dfad92288.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSE54>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSE54>>(v1);
    }

    // decompiled from Move bytecode v6
}

