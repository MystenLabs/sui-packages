module 0xc2ca4faa8ab2326cd979307fbf0be378fcc6e0fd125513d381dc2b52b4a8027f::jokersui {
    struct JOKERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKERSUI>(arg0, 6, b"JOKERSUI", b"Joker On Sui Fun", x"4d616b6520535549205374726f6e6720776966204a6f6b6572204f6e207355492e44657873637265656e6572207061696420646f6e652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_27_324232c7fb_815c370712.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOKERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

