module 0x6dc5e1168ff815a24b4ebbe0a8fbc96ab9a5a80147d896624e6df8d3f37cf01e::smoon {
    struct SMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOON>(arg0, 6, b"SMOON", b"Suilor Moon", b"Get ready to go to the moon!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_fc20ca35ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

