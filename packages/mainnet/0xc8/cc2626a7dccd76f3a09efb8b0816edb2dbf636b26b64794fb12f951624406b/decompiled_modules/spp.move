module 0xc8cc2626a7dccd76f3a09efb8b0816edb2dbf636b26b64794fb12f951624406b::spp {
    struct SPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPP>(arg0, 6, b"SPP", b"Seal plush planet", b"SPP-111 on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fe8d1e884eec9ce80383fc2c94062a3d_9f876b5785.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

