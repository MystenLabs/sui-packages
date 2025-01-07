module 0xda0f2b64eb2e816064ed313bb6409687e40320f5c6e2757cb8a69eb4ee219817::doodle {
    struct DOODLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODLE>(arg0, 6, b"Doodle", b"Doodles on SUI", b"Airdropping 10,000 Doodles to community and token holders once bonded", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_07_090348_c688bdd292.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOODLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

