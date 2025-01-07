module 0xb636c476688b832dbe10fedcd6a046517a5c1395d3a02ed5697d0eadedf43b18::ride {
    struct RIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIDE>(arg0, 6, b"RIDE", b"SUIRIDE", b"RIDE RIDE RIDE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zzz_d682d21c63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

