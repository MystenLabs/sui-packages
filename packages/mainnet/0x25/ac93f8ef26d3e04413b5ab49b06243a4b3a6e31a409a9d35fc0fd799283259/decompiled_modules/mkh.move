module 0x25ac93f8ef26d3e04413b5ab49b06243a4b3a6e31a409a9d35fc0fd799283259::mkh {
    struct MKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKH>(arg0, 6, b"MKH", b"mkh", b"my very own token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_d198679cfb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

