module 0xbe75d4fcfc1b8e3ce65b562b58790ec0801c0e3f84bc122c7d21722cf69f6ff2::scult {
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

