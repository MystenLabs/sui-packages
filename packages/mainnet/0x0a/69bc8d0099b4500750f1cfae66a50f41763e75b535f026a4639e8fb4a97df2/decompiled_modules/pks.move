module 0xa69bc8d0099b4500750f1cfae66a50f41763e75b535f026a4639e8fb4a97df2::pks {
    struct PKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKS>(arg0, 6, b"PKS", b"PIKA SUI", b"PIKA PIKA PIKASUIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_28_12_24_55_9d5cdde947.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

