module 0xfd1f724bcfe7b677e7c500f2fd87217d03eeda7a5eac9a0fc99974c9b968547e::suirek {
    struct SUIREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREK>(arg0, 6, b"SUIREK", b"Suirek", b"Suirek: The blue giant of SUI universe, ready to dominate!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0848_73ecfbf411.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREK>>(v1);
    }

    // decompiled from Move bytecode v6
}

