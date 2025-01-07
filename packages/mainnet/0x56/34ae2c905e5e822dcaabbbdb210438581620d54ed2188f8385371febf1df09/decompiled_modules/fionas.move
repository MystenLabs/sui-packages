module 0x5634ae2c905e5e822dcaabbbdb210438581620d54ed2188f8385371febf1df09::fionas {
    struct FIONAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIONAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIONAS>(arg0, 6, b"Fionas", b"Fiona", b"Fiona's journey to stardom began under challenging circumstances. Born six weeks prematurely, she faced significant health challenges that were closely followed by millions worldwide. The Cincinnati Zoo's documentation of her struggle and eventual recovery turned her into a viral sensation, with Fiona becoming a symbol of perseverance and an ambassador for her species", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_d4723ff483.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIONAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIONAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

