module 0x4f78d5257cb1776d61c4ee1a3069e3e07a68ba10f72b3306442956574b31fd4::canana {
    struct CANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANANA>(arg0, 6, b"CANANA", b"Canana on sui", x"0a43617420696e20612062616e616e6120737569742e204974277320612063616e616e612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053915_783acd5195.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

