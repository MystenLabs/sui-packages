module 0x94c6cdd191cfbd574437eef0878a5fb6b5bec3b65c023d6c284d950eeb6567a0::catinu {
    struct CATINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATINU>(arg0, 6, b"CATINU", b"Catinu", x"2054686520726f6172206563686f65732066726f6d2074686520707265686973746f72696320706173742e2e2e0a20436174696e7520697320616c697665206f6e20405375694e6574776f726b210a4e6f74206a7573742061206d656d65636f696e202061206c6567656e6461727920737065636965732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069902_46574e4f72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

