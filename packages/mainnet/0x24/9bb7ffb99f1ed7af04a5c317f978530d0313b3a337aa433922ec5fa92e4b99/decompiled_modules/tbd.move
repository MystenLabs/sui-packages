module 0x249bb7ffb99f1ed7af04a5c317f978530d0313b3a337aa433922ec5fa92e4b99::tbd {
    struct TBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBD>(arg0, 6, b"TBD", b"Taped Banana Duck", b"TO BE ANNOUNCED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/taped_duck_88ec8b91b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

