module 0x1df363f9e9151d2bda2110e1fc3182615e2555c00941c9ffa07f1b678abfec65::welovesui {
    struct WELOVESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WELOVESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WELOVESUI>(arg0, 6, b"WELOVESUI", b"WE LOVE SUI", b"We Love Sui!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7pjpua_8e86622191.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WELOVESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WELOVESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

