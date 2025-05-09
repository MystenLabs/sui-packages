module 0x5e1f6715ce8a31a3ba8f58547d41f9edb21541221e68b7ce51f34e9070e0574a::ntc {
    struct NTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTC>(arg0, 6, b"NTC", b"Nautical Space", b"A universe soldier to peacekeeping the universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidorg3sh57lkjnasj3huzgkdgdts2z2lfo5dhnix4ttamks2nl7gm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

