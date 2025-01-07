module 0xdbcc6243fbc45829a80659792ff8ae164ef22cae218e0e6befecc7b85fda5e00::spb {
    struct SPB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPB>(arg0, 6, b"SPB", b"Sui polar bear", b"Polar bear  on  sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_17_24_24_d3dc0eee00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPB>>(v1);
    }

    // decompiled from Move bytecode v6
}

