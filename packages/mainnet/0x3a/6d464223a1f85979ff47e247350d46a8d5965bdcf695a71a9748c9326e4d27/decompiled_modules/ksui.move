module 0x3a6d464223a1f85979ff47e247350d46a8d5965bdcf695a71a9748c9326e4d27::ksui {
    struct KSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSUI>(arg0, 6, b"Ksui", b"Calsium", b"Pain Pain without Calsium", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_767147458e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

