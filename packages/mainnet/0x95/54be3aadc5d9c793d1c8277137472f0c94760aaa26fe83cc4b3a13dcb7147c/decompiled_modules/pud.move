module 0x9554be3aadc5d9c793d1c8277137472f0c94760aaa26fe83cc4b3a13dcb7147c::pud {
    struct PUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUD>(arg0, 6, b"PUD", b"FUD THE PUG", b"FUD is the lucky pug of Sui Network. Made by the community, for the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/62edfccb_5ddd_4575_998c_49e077040de8_1a775c853f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

