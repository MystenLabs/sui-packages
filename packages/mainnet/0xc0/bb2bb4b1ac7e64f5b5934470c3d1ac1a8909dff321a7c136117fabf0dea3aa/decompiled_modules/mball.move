module 0xc0bb2bb4b1ac7e64f5b5934470c3d1ac1a8909dff321a7c136117fabf0dea3aa::mball {
    struct MBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBALL>(arg0, 6, b"Mball", b"Meatball", b"Meet Meatball, the cutest wizard dog! With his floppy ears and tiny hat, he spreads joy and magic wherever he goes. Join him on a fun, enchanting adventure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tambahkan_judul_ef5dddc6e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

