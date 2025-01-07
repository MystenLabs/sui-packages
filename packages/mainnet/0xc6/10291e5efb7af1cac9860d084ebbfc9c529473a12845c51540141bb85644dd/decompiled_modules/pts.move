module 0xc610291e5efb7af1cac9860d084ebbfc9c529473a12845c51540141bb85644dd::pts {
    struct PTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTS>(arg0, 6, b"PTS", b"PETER TODD", b"Satoshi Nakamoto's Secret ID. HBO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bitcoin_developer_Peter_Todd_believes_Lightning_Network_is_a_maturinga_6910f57117.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

