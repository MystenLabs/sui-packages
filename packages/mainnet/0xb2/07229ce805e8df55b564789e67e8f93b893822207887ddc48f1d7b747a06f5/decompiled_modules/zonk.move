module 0xb207229ce805e8df55b564789e67e8f93b893822207887ddc48f1d7b747a06f5::zonk {
    struct ZONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZONK>(arg0, 6, b"ZONK", b"ZONKSUI", b"SUIZONK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_3b24c76ba1.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

