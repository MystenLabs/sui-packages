module 0xeeca8b63178b4fbe32c7f6102580c4d73ba08a6af6f2f1eea3cb80f34e1bb16a::tonf {
    struct TONF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONF>(arg0, 6, b"Tonf", b"Tonfuck", b"Fuck Ton", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifcu324ias76nirow7zyakgsa5biq7axfuue2f36mfzf7p6tz3eeu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TONF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

