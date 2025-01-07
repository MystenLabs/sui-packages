module 0xbb282ca520223a5258ced9fcbf5eefba451b146f25a4ced992cfc1471326824e::suc {
    struct SUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUC>(arg0, 6, b"SUC", b"Sui Cat", x"205375692043617420697320746865206e65787420626967206d656d6520636f696e206f6e2074686520537569204e6574776f726b21200a2050726963652073757267657320616e642067726f77696e67206c697175696469742d796d61737369766520706172746e6572736869707320636f6d696e6720736f6f6e210a20446f6e74206d697373206f7574206f6e207468652070726f666974732d6a6f696e20746865205375692043617420636f6d6d756e697479206e6f77210a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_19_20_15_12_891136c020.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

