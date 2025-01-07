module 0x337b138ff0b0328c1ec6437cf9222a06b0732456915e3ad806c66d2327108720::trempsui {
    struct TREMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREMPSUI>(arg0, 6, b"TREMPSUI", b"$TREMPSUI", b"$TREMPSUI brings the spirit of Make Sui Great Again to the world of blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_0c6f6a8e5b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREMPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

