module 0x7c572045fe476aabfc8a1d7a005bb1a448873ee0c970a4ee58b74c778ddd85bd::billy {
    struct BILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLY>(arg0, 6, b"BILLY", b"Billybob", b"Saddle up, partner! Meet BillyBob, the Wild Wests sharpest-shooting, cash-collecting, scaly bounty hunter. This geckos got grit, and he's on a mission!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_10_21_32_04_42f29bf6a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

