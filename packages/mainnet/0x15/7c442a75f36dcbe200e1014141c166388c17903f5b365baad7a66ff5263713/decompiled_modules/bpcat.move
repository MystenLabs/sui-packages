module 0x157c442a75f36dcbe200e1014141c166388c17903f5b365baad7a66ff5263713::bpcat {
    struct BPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPCAT>(arg0, 6, b"BPCAT", b"Blueprint Cat", b"The meow-tastic plan to reward all Sui homies is now ready! There's no room fur failure $BPCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_8112b26eb0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

