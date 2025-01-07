module 0x6946adacb3b1ded71f3a6a143b33794a5f8c8106b570a9229fdfb3bef14f466c::muda {
    struct MUDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDA>(arg0, 6, b"MUDA", b"MUDAPEDIA", b"We, at Mudapedia, understand that the digital era has opened the door to unlimited opportunities, and we are here as a smart and trusted solution to help you grow your business in an ever-changing world. As an innovative company, we offer a range of services specifically designed to meet the needs of modern businesses.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Muda_275a82670b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

