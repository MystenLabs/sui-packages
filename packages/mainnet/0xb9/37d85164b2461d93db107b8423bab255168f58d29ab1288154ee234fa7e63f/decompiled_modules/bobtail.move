module 0xb937d85164b2461d93db107b8423bab255168f58d29ab1288154ee234fa7e63f::bobtail {
    struct BOBTAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBTAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBTAIL>(arg0, 6, b"BOBTAIL", b"Bobtail cat", x"426f627461696c204361740a546865204a6170616e65736520426f627461696c20636174206973206f6e65206272656564206f6620636174207468617420697320756e6971756520696e20746861742069742068617320746865207368617065206f6620612062756e646c65207461696c2e2054686973206272656564206f662063617420616c736f20636f6d65732066726f6d204a6170616e20617320697473206e616d6520686173206578697374656420696e2074686520636f756e7472792073696e63652074686f7573616e6473206f662063656e74757269657320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040498_9f9032ad70.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBTAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBTAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

