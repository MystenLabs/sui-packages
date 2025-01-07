module 0xb208c55a25c2e5bdaac313187fcae36fc74f6f59489951676bdd5efb526a8b2c::yuka {
    struct YUKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUKA>(arg0, 6, b"YUKA", b"SUIDOGYuka", b"Yuka loves you all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yuka_eada4046ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

