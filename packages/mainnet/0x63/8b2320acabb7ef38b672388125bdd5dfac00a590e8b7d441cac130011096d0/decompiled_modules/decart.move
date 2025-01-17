module 0x638b2320acabb7ef38b672388125bdd5dfac00a590e8b7d441cac130011096d0::decart {
    struct DECART has drop {
        dummy_field: bool,
    }

    fun init(arg0: DECART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DECART>(arg0, 6, b"DECART", b"Decart ai", b"A new era of real-time generative experiences, enabled by cutting-edge AI efficiency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SADASDAADA_32b67e6592.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DECART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DECART>>(v1);
    }

    // decompiled from Move bytecode v6
}

