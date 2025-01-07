module 0x107e70b408ef6a4221b8d5e192e3e1b3005daa9845e4418bfb19efc14d1b5d90::jaya {
    struct JAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAYA>(arg0, 9, b"JAYA", b"Jaya", b"Jaya the dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/16978073/file/original-5d35c03c4f41972ebe6c49b47044f4c8.png?resize=1024x768")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JAYA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAYA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

