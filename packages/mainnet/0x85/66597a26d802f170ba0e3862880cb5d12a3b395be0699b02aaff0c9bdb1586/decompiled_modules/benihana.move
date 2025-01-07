module 0x8566597a26d802f170ba0e3862880cb5d12a3b395be0699b02aaff0c9bdb1586::benihana {
    struct BENIHANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENIHANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENIHANA>(arg0, 6, b"BENIHANA", b"Benihana", b"Small eye fire up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0784_6483809e8d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENIHANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENIHANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

