module 0x11d308c980877d8f4cb92938dbaf259fc3b12177fede4fb969536e6c37a8a20c::wai {
    struct WAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAI>(arg0, 6, b"WAI", b"Watson - AI", b"famous for its victory in the Jeopardy! quiz show, is also used in applications like healthcare and data analysis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Watson_pict_305d146b3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

