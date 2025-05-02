module 0x4abdd68bba56da21f6624ee7701192de804435475aad255052c9465f8e4a8e3::DON {
    struct DON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DON>(arg0, 6, b"DON", b"Don Pollo", b"Ging gang goolie goolie goolie goolie watcha Ging gang goo, ging gang goo Ging gang goolie goolie goolie goolie watcha Ging gang goo, ging gang goo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmSuk5ju62sz6FoKHAjegEnCjvQgKYnyk1PiY26KvnN5ax")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

