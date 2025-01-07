module 0x8dc1a40a4fad500124959bf4cc91737550178bc01d43ef0917ffa75976d1e04f::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 6, b"Hop", b"Hop aggregator", b"hop fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hop_ab730f8405.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

