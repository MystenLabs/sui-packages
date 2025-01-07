module 0x48d5dd97e1e9724623aaac5c59af187bf1c1b311108e2eb8caf82cf4a64f3b41::derp {
    struct DERP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERP>(arg0, 6, b"DERP", b"DERPMAN", b"have no fear , derpman is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OSL_2k5_Bq_400x400_9bdc050737.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERP>>(v1);
    }

    // decompiled from Move bytecode v6
}

