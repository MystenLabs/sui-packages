module 0x464108ffed22a1a047c655e08af23f69bc13a08b3998212856435b1bf4c127e9::swc {
    struct SWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWC>(arg0, 6, b"SWC", b"Sui Warrior Cat", b"Sui Warrior Cat Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6178_8f5c2cb884.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWC>>(v1);
    }

    // decompiled from Move bytecode v6
}

