module 0xdcbaa491938d75dc16ef47b313ad2e6e96d45492b0367e62627527d92033a377::fun9 {
    struct FUN9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN9>(arg0, 9, b"FUN9", b"9K Fun", b"FIFO is a common algorithm used to match orders based on price and time. It prioritizes orders based on the order in which they were received, with the earliest timestamp being first.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/bd8338da6db5e892d86171e83982fe1cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUN9>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN9>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

