module 0xa6444b39a5a5e69f601af834f79fcc6d0acee5a884875bc9b6072d5ea9b855a7::dip {
    struct DIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIP>(arg0, 6, b"DIP", b"dipman", x"2d206e657665722073656c6c2074686520746f700a2d20616c776179732062757920746865206469700a0a6675636b20736f6369616c732077652070616d70696e2074686973", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Skjermbilde_2024_11_10_215231_b116423eb4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

