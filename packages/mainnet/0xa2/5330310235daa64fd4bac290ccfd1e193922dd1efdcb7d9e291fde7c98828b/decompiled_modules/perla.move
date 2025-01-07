module 0xa25330310235daa64fd4bac290ccfd1e193922dd1efdcb7d9e291fde7c98828b::perla {
    struct PERLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERLA>(arg0, 6, b"PERLA", b"Perla SUI", b"The most seductive female on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241201_192042_2_85d5f2d6eb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

