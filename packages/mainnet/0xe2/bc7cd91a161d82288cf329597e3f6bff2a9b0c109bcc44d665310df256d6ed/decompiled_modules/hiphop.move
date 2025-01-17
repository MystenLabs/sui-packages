module 0xe2bc7cd91a161d82288cf329597e3f6bff2a9b0c109bcc44d665310df256d6ed::hiphop {
    struct HIPHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPHOP>(arg0, 6, b"HIPHOP", b"Hiphop", b"Hop onto Sui & fairlaunch a coin instantly with just a couple of clicks. Fast, Safe, Free: Good tek.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737109829802.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPHOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPHOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

