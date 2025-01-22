module 0x53e49cc58c0ac2ac239be023f590db0dc9576b15c0b3e28da8e4696ffb044b81::kumamon {
    struct KUMAMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMAMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMAMON>(arg0, 6, b"KUMAMON", b"Kumamon", b"Welcome to the world of kumamon on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028318_0d99f2d7fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMAMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUMAMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

