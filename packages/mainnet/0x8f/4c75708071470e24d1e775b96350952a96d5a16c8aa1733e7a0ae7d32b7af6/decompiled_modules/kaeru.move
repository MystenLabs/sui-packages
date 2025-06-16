module 0x8f4c75708071470e24d1e775b96350952a96d5a16c8aa1733e7a0ae7d32b7af6::kaeru {
    struct KAERU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAERU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAERU>(arg0, 6, b"Kaeru", b"Kaeru no Kenshi", b"You have entered the realm of Kaeru born of rain, risen by grit. This is not just a project. It is a path. A movement for those who train in silence, strike with purpose, and believe when no one else does.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidlynppbvxuqq6pxrm2sjl43fxgy6llgmout57bx4wycx2jknzq7i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAERU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAERU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

