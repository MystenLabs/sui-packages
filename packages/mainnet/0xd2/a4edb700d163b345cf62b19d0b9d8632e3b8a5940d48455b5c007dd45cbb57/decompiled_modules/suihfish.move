module 0xd2a4edb700d163b345cf62b19d0b9d8632e3b8a5940d48455b5c007dd45cbb57::suihfish {
    struct SUIHFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHFISH>(arg0, 6, b"SUIHFISH", b"SUIHOPFISH", b"SUIHOPFISH to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1000026486_b21c8ed1df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

