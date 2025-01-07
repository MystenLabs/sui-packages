module 0x67c3c4f52b5776303ff2cf7d2c6c042d0d726a76a9e66cd668ce21406bdc273c::scz {
    struct SCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCZ>(arg0, 6, b"SCZ", b"Sucziba", b"Decentralized power. Free , always crypto. We will fly it to the moon with decentralized power", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ffe9_493c_877d_750f87ca13a2_21b21ab9fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

