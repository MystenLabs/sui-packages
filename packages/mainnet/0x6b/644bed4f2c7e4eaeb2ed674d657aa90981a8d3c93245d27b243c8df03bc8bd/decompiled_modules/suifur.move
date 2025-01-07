module 0x6b644bed4f2c7e4eaeb2ed674d657aa90981a8d3c93245d27b243c8df03bc8bd::suifur {
    struct SUIFUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUR>(arg0, 6, b"SuiFur", b"Suifur", b"Meet FURRY by Matt Furie, the ultimate lovable dad with a heart as big as a warm hug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058456_0173e5044f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

