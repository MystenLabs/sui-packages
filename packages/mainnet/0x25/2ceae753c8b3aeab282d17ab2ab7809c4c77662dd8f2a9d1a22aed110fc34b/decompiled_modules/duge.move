module 0x252ceae753c8b3aeab282d17ab2ab7809c4c77662dd8f2a9d1a22aed110fc34b::duge {
    struct DUGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUGE>(arg0, 6, b"DUGE", b"SDUGE", b"Let's send the funny dog to the moon.Let's send the funny dog to the moon buy buy buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012812_d4d77b20ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

