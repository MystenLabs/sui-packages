module 0xcf01262726b0adade9a702e27eea92efdc028155f205ef8632faf1c5aee4132d::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"SUINIC", b"Suinic", b"Suinic moon, no pepe moon Suinic moon today i s a Suinic da y toda i Suinic moon. yes Suinic go to da moon. u is cuming wif Suinic?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031501_113a2fd323.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

