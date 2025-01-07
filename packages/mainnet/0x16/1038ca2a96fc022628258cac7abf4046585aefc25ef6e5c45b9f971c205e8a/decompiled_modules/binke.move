module 0x161038ca2a96fc022628258cac7abf4046585aefc25ef6e5c45b9f971c205e8a::binke {
    struct BINKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINKE>(arg0, 6, b"Binke", b"Binke Game", b"Let's play the Binke Game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/96c978f16325b360_ea814ffa2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

