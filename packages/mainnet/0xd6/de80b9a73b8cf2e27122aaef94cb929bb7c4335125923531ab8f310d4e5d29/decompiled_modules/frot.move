module 0xd6de80b9a73b8cf2e27122aaef94cb929bb7c4335125923531ab8f310d4e5d29::frot {
    struct FROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROT>(arg0, 6, b"Frot", b"a tiny frog on sui", b"i'm just a tiny frog in the wild wold of sui. You don't have to worry bout me :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/frot_48e4620088.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

