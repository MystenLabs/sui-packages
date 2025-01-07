module 0xd4b2ab19c0aa8c4a4eb33a9bc4f2a4a569189cb47d8bb9172d3df03096b2ecc6::bluedory {
    struct BLUEDORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEDORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDORY>(arg0, 6, b"BLUEDORY", b"FINDING DORY", x"446f727920626567696e7320612073656172636820666f7220686572206c6f6e672d6c6f737420706172656e747320616e642065766572796f6e65206c6561726e73206120666577207468696e67732061626f757420746865207265616c206d65616e696e67206f662066616d696c7920616c6f6e672074686520776179206f6e205375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3648_f6c0c819c3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEDORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

