module 0xf757a4350748ff898cc96cc376c481207a332d5fabf9b57ce9ea1b1754ea6b2e::orb {
    struct ORB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORB>(arg0, 6, b"ORB", b"Orboros", b"Orboros is a project about a story told in a comic. Dr. teus and his fellow universe travelers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731075478793.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

