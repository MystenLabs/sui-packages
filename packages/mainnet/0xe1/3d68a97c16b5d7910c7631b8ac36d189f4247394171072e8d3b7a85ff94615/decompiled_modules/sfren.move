module 0xe13d68a97c16b5d7910c7631b8ac36d189f4247394171072e8d3b7a85ff94615::sfren {
    struct SFREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFREN>(arg0, 6, b"SFREN", b"SUIFRENS", b"SuiFrens are beloved imaginative, inventive creatures traversing the internet, seeking fellow pioneers to build new connections and friendships.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suifrens_09a2ddcac5_6705b9dc94_07b830c817.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

