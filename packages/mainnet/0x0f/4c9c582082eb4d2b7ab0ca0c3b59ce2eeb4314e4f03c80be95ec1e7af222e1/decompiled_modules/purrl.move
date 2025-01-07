module 0xf4c9c582082eb4d2b7ab0ca0c3b59ce2eeb4314e4f03c80be95ec1e7af222e1::purrl {
    struct PURRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURRL>(arg0, 6, b"PURRL", b"Purrl Sea Cat", b"Purrl cat is found deep in the Sui Sea. It evokes a sense of mystery for degens and scientist around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sea_cat_6e0ebecc3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

