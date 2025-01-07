module 0x42f4dd3d7541e9561938fee07ea573fe7fe7b0aa7b81ecc9eb22a9b2a5fb65f8::duckonsui {
    struct DUCKONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKONSUI>(arg0, 6, b"DuckonSui", b"Duck", x"4475636b207465616d206f6e205375690a436f6d652077697468207573206475636b206475636b206475636b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4004_552b7786d5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

