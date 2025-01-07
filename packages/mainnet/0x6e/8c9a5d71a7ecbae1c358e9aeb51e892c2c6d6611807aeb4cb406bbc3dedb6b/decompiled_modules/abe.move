module 0x6e8c9a5d71a7ecbae1c358e9aeb51e892c2c6d6611807aeb4cb406bbc3dedb6b::abe {
    struct ABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABE>(arg0, 6, b"ABE", b"Abe Dog", x"24416265206973206120646f672077686f206c6f76657320746f207377696d2c206f68206f6620636f7572736520657370656369616c6c79207769746820746865207375692074686174206865206c696b657320746865206d6f737420776174657220200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055539_7c5130023e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABE>>(v1);
    }

    // decompiled from Move bytecode v6
}

