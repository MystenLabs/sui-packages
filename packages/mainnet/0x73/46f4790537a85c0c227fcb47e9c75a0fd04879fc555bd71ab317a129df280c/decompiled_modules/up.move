module 0x7346f4790537a85c0c227fcb47e9c75a0fd04879fc555bd71ab317a129df280c::up {
    struct UP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UP>(arg0, 6, b"UP", b"Up only", b"don't miss it bro, we're just going to the top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031300_29dc35b16c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UP>>(v1);
    }

    // decompiled from Move bytecode v6
}

