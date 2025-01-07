module 0xb9610ca2b73303366c8824446053b6e3cd0c132828c7aa71f0a31c59ee91e611::croc {
    struct CROC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROC>(arg0, 6, b"CROC", b"Croc", x"49274d20412043415420574954482043524f4353204f4e204d592048454144204c455427532047524f5720555020414e442047455420474f4c4420464f52204f55522048454144530a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Croc_1a23160078.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROC>>(v1);
    }

    // decompiled from Move bytecode v6
}

