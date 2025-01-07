module 0x9d651d02fef6e555fae4be27258d25c5fc662d81232c0715fdddd9bfdf30ef15::dok {
    struct DOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOK>(arg0, 6, b"DOK", b"Dok Universe", b"I'm DOK, the coolest dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_e8a05ee29f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

