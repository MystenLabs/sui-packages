module 0x888fafb2d1f7f6604eb4c84e835cd63fb1302e8d929de51f36ff069bc5833132::monsto {
    struct MONSTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSTO>(arg0, 6, b"MONSTO", b"$$MONSTO-Monstoo", b"Hi! Im Monstoo, your friendly baby monster, trying to live a normal life (with a few monstrous quirks).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_20_40_45_1604fcda40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONSTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

