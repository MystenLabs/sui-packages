module 0x32d0023057f80527de6bad671295ff8e45776eaf166f77eba36eec637c55c532::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 6, b"PAC", b"America PAC", b"Read @America to understand whyl'm supporting Trump for President", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2ff66f41cf5f5961f9e58aad7ed8a64_64a0b2fb38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

