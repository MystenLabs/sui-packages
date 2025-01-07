module 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 9, b"CETUS", b"Cetus Token", b"CETUS is the native token of Cetus Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uxcdefo3r2uemooidt2kk2stykakvwd2m6nasg5lhbfaxemm4i3a.arweave.net/pcQyFduOqEY5yBz0pWpTwoCq2HpnmgkbqzhKC5GM4jY")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<CETUS>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<CETUS>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

