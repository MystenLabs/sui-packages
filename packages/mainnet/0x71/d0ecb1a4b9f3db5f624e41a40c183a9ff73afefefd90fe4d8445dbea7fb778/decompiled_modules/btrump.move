module 0x71d0ecb1a4b9f3db5f624e41a40c183a9ff73afefefd90fe4d8445dbea7fb778::btrump {
    struct BTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTRUMP>(arg0, 6, b"BTRUMP", b"BLUETRUMP", b"BLUE IS THE COLOR OF VICTORY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5648_e00ad33fbe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

