module 0xe066db4fdfb41a32cedb35be5322a6578b1a4ce3bd2e2ca1b3fa271bd8c677b3::dai {
    struct DAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAI>(arg0, 6, b"DAI", b"DOLPHIN AI", b"I AM THE FIRST DOLPHIN MADE BY AI. I AM HAPPY TO BE ON THE SUI CHAIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004366_51e78aaaeb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

