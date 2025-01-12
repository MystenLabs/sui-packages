module 0x74c2e9f48679ed2a0a0021c41f9e25a7e1c4d4c3c2d75cdd8e70d877a4bb7a4f::trumponsui {
    struct TRUMPONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPONSUI>(arg0, 6, b"Trumponsui", b"Trump", b"Trump is future of crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7102_517f769daa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

