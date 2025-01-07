module 0x4acb80b808103d0bc25e5aa42c54eaea80a5af260acd9434a8336f127df33f54::scult {
    struct SCULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCULT>(arg0, 6, b"SCULT", b"SUI CULT", b"Entering the spooky november all of the fishes in the sui chain need a cult to join!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_blue_cult_leader_33c62b53a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCULT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

