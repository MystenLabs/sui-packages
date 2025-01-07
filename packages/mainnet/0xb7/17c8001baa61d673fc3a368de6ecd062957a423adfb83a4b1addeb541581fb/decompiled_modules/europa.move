module 0xb717c8001baa61d673fc3a368de6ecd062957a423adfb83a4b1addeb541581fb::europa {
    struct EUROPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUROPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EUROPA>(arg0, 6, b"Europa", b"europa", b"Jupiter's moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004799_959b9f4dff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUROPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EUROPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

