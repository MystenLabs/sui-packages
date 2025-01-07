module 0xb79222a4e9a272ad77420ed9ee11d031f786ad9dfe019152edc735a7dbe239eb::fight {
    struct FIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGHT>(arg0, 9, b"FIGHT", b"Fight Fight Fight", b"Memorial in MAGA movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1791134452690923520/s4T-A-mF.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIGHT>(&mut v2, 333000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

