module 0xa3c7669911a61ff2c60f2d02caaaf456de5f0ea037d97807d06aa25903482bf8::bmg {
    struct BMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMG>(arg0, 6, b"BMG", b"Baby Maga Sui", x"546865206d656d65636f696e206d61726b657420686173207365656e206974732066616972207368617265206f6620766972616c207375636365737365732c20616e6420616d6f6e67207468656d2c20245065706520616e64205472756d707320244d41474120636f696e207374616e64206f75740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/black_box_2f6e51765c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

