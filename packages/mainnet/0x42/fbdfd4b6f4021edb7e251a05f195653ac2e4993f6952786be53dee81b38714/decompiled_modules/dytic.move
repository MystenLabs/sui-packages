module 0x42fbdfd4b6f4021edb7e251a05f195653ac2e4993f6952786be53dee81b38714::dytic {
    struct DYTIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYTIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYTIC>(arg0, 6, b"DYTIC", b"Do You Think I Care", b"Sometimes caring less is the ultimate freedom. Let's build a community together where we focus on creating a strong mindset and lifestyle. This is imo a great way to have fun, earn, learn, empower and inspire. Who wants to take this ride? Join TG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733181445540.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYTIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYTIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

