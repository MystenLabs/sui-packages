module 0xc31c2125080215950169135118ee0d40bd3c4cbc9af7ec7ef2e8641b8ad6eb13::gayfish {
    struct GAYFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAYFISH>(arg0, 6, b"GayFish", b"Gay Fish", b"Gay West, let's swim against the current, darling. There's always room in the sea for a fabulous gay fish! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gay1111_06288ba38a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAYFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

