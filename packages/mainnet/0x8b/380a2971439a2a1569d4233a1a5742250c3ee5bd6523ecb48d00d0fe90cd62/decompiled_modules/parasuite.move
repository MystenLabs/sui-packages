module 0x8b380a2971439a2a1569d4233a1a5742250c3ee5bd6523ecb48d00d0fe90cd62::parasuite {
    struct PARASUITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARASUITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARASUITE>(arg0, 6, b"PARASUITE", b"ParaSUIte", b"AIRDROP INCOMING!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_00_38_15_cdf22eb00a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARASUITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARASUITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

