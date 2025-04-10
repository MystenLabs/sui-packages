module 0x59932f5f38d29ea58291a5e47ffcf83d288abf5c0e0897acc635f6a3478841a3::otty {
    struct OTTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTY>(arg0, 6, b"OTTY", b"OTTY ON SUI", b"The speedy otter of the Sui seas! Known for its swift moves and playful spirit, $OTTY is making waves on the Sui network. Hop on and race through the waters with this unstoppable otter!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OTTIER_9bf750e1e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

