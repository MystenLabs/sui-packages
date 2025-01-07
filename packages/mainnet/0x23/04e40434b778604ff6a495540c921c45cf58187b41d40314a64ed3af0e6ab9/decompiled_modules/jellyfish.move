module 0x2304e40434b778604ff6a495540c921c45cf58187b41d40314a64ed3af0e6ab9::jellyfish {
    struct JELLYFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLYFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLYFISH>(arg0, 6, b"JELLYFISH", b"Sui JellyFish", b"$JELLYFISH COME TO SUI CHAIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jellyfish_pink_7e9c110af4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLYFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLYFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

