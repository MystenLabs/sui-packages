module 0x510deb3f16e5a926c04ae866626ed82d36ed712816859b5138b0087787b05d4d::suifur {
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

