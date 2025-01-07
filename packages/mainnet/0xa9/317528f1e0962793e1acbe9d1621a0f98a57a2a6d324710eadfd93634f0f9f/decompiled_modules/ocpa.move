module 0xa9317528f1e0962793e1acbe9d1621a0f98a57a2a6d324710eadfd93634f0f9f::ocpa {
    struct OCPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCPA>(arg0, 6, b"OCPA", b"Octopass On Turbos", b"Octopass is coming to Sui market - A meme token acting like a meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731004809007.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

