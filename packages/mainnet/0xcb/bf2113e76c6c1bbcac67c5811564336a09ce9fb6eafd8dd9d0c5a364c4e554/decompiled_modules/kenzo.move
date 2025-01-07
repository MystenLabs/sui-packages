module 0xcbbf2113e76c6c1bbcac67c5811564336a09ce9fb6eafd8dd9d0c5a364c4e554::kenzo {
    struct KENZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENZO>(arg0, 6, b"KENZO", b"Kenzo on SUI", b"$KENZO is a teenage tiger who is searching for his identity in the world of sui. he can be anything! KENZO's energy and vibe will pump fun into sui !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_2_Recovered_5299d5837b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KENZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

