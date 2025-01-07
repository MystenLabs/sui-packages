module 0x5a453c9d00c4b2db4e93b295cd2bc9872661a984c1be284ad6b91005b8ae90a3::hnc {
    struct HNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNC>(arg0, 6, b"HnC", b"Hodl and chill", x"4974277320323032352c206c657427732068617665206120676f6f642079656172200a486f646c20616e64206368696c6c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016417_9177a076c3.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

