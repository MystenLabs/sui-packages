module 0x9876670ad83b925965f524be7a49ba5077b85813a423db0e8aba9a35094b1601::cnol {
    struct CNOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNOL>(arg0, 9, b"CNOL", b"Christopher Nolana", b"Sir Christopher Edward Nolan is a British and American filmmaker. Known for blockbusters with complex storytelling produced for Hollywood studios, he is considered a leading filmmaker of the 21st century.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://google.com/a.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CNOL>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNOL>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CNOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

