module 0x1d9ac5c18b362d533f9f1f3f52d1878012fb72ddc64dc5a200794df85d32a16a::bao {
    struct BAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAO>(arg0, 6, b"BAO", b"BaoMemeSui", b"In the lush bamboo forest of the sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000355_6fbd210361.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

