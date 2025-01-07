module 0x68d97ee54e5b6bb08fd42d4a37b600ffd14bc0893cbe71b94c60b392acc60038::mtpa {
    struct MTPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTPA>(arg0, 6, b"MTPA", b"Make Trump President", b"Make Trump President AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043586_3c2edcf328.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

