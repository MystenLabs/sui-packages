module 0xd7e79aec1f83112850c815cc7263a40076d330bc55a0ac6d6de04b4bb22a2630::db {
    struct DB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DB>(arg0, 6, b"DB", b"DRAGONBABY", b"Dragons symbolize power, wisdom, strength, and protection in Eastern cultures, while representing greed, destruction, and danger in Western mythology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_9138bf2731.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DB>>(v1);
    }

    // decompiled from Move bytecode v6
}

