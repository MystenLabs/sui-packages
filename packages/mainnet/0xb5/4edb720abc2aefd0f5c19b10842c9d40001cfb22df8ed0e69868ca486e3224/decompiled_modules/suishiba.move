module 0xb54edb720abc2aefd0f5c19b10842c9d40001cfb22df8ed0e69868ca486e3224::suishiba {
    struct SUISHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIBA>(arg0, 6, b"SUISHIBA", b"Sui Shiba", b"SuiShiba is the latest meme sensation on the Sui network, set to launch on MovePump.com. With the security and reliability of the Sui ecosystem and the backing of MovePump, SuiShiba is positioned as a safe and promising project. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/received_1526803568207836_cd8169a81c_b49897e26f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

