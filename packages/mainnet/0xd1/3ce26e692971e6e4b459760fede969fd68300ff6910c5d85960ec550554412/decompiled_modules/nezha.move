module 0xd13ce26e692971e6e4b459760fede969fd68300ff6910c5d85960ec550554412::nezha {
    struct NEZHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEZHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEZHA>(arg0, 6, b"NeZHa", b"NEZHA", b"$NEZHA movie has just set a box office record, let's celebrate it. -", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9233449484318_e36496519b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEZHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEZHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

