module 0x4911b53da693361d0fb04e98486ae50d4f00164506797a005c9486b231f9e558::mber {
    struct MBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBER>(arg0, 6, b"MBER", b"Sui Memberberries", b"\"Member runners?\" Yeah, i member... member, member bull run? Heh.. i member", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000063024_a16185004f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

