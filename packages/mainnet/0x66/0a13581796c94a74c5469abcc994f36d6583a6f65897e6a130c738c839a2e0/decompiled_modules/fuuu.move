module 0x660a13581796c94a74c5469abcc994f36d6583a6f65897e6a130c738c839a2e0::fuuu {
    struct FUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUUU>(arg0, 6, b"FUUU", b"Fuuuuuuu", b"Fuuuuuuuuuuuuuuuuuuuuuuuuuuuuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_06_17_05_14_99c27c783e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

