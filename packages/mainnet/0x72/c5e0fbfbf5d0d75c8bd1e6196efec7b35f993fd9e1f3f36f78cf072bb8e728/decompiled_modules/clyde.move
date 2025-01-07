module 0x72c5e0fbfbf5d0d75c8bd1e6196efec7b35f993fd9e1f3f36f78cf072bb8e728::clyde {
    struct CLYDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLYDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLYDE>(arg0, 6, b"Clyde", b"Clyde AI", b"Meet Clyde, Discords New AI assistant, join him as he discovers the adventure's of the sui blockchain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/clyde_616956268e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLYDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLYDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

