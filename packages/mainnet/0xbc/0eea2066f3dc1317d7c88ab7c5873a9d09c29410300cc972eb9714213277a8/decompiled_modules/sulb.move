module 0xbc0eea2066f3dc1317d7c88ab7c5873a9d09c29410300cc972eb9714213277a8::sulb {
    struct SULB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULB>(arg0, 6, b"SULB", b"SUICLUB", b"All Memes On Club Lets Send This", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_13_21_58_5ea3479f00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULB>>(v1);
    }

    // decompiled from Move bytecode v6
}

