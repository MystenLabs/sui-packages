module 0xb8c931e224531df452dae4401e90b15ae30c9e10e1e26f538e0769fa731c1694::gicat {
    struct GICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GICAT>(arg0, 6, b"GICAT", b"gif cat", b"$GICAT is the first fully animated cat artcoin/memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000122379_a4f576ceb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

