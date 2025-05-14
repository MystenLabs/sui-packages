module 0x39c82d9e4d931995b522b4c40fd509d0c5ee624d12403e1d8820a712a055defa::mrm {
    struct MRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRM>(arg0, 6, b"MRM", b"Mister Mime", b"BUY MRM.   Or be stuck inside in an invisible box.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7206_615985fbe3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

