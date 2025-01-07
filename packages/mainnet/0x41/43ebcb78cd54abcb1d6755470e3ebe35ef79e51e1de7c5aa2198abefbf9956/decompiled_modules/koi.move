module 0x4143ebcb78cd54abcb1d6755470e3ebe35ef79e51e1de7c5aa2198abefbf9956::koi {
    struct KOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOI>(arg0, 6, b"Koi", b"Koi AI", b"The Koi token is a utility token built on the Sui network. The total supply of Koi tokens is fixed, with a deflationary mechanism in place to ensure long-term value. Join the Koi Network community and be a part of the future of Web3 creation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733670661059.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

