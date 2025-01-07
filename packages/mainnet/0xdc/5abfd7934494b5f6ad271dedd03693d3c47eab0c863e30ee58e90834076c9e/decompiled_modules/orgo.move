module 0xdc5abfd7934494b5f6ad271dedd03693d3c47eab0c863e30ee58e90834076c9e::orgo {
    struct ORGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORGO>(arg0, 6, b"ORGO", b"Orgo Sui", b"Orgo sui is unique meme, dive into crypto riches with ocean gorilla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001947_bc3bd9138b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

