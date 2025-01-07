module 0xa1addd5dab7eafe560c3139f5fe4880b3cdd7bb36cc566ec9c4362d5d8169f0c::goubi {
    struct GOUBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOUBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOUBI>(arg0, 6, b"GOUBI", b"Goubi on sui", b"$GOUBI Is a mysterious goat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056311_9641f61ff7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOUBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOUBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

