module 0x69cde5381e7fa702e778b95f9b6351b067ce41ebd6068e5d0110e7707f04e41a::bcow {
    struct BCOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCOW>(arg0, 9, b"BCOW", b"BeeCow", b"project to share with the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/361b6480-dc1a-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCOW>>(v1);
        0x2::coin::mint_and_transfer<BCOW>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCOW>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

