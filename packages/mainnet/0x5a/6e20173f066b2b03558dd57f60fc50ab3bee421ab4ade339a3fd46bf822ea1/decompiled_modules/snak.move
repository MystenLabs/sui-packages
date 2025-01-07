module 0x5a6e20173f066b2b03558dd57f60fc50ab3bee421ab4ade339a3fd46bf822ea1::snak {
    struct SNAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAK>(arg0, 6, b"SNAK", b"Suinake", b"As one of the first meme tokens born on the Sui network, Suinake offers much more than just being another cryptocurrency. Built on the speed and security features of the Sui ecosystem, Suinake emerged with a vision that prioritizes fun and community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953131992.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

