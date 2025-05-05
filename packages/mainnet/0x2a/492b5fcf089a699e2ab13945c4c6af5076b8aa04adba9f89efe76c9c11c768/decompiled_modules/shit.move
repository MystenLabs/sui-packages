module 0x2a492b5fcf089a699e2ab13945c4c6af5076b8aa04adba9f89efe76c9c11c768::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 9, b"Shit", b"Shit coin", b"Shitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d9fa36d2dc01c42c18c6ac472df3d28ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

