module 0xd4c0425c15adaf097bb08614bac38de29c8d676c0cfc4133b2db763d2ce1b618::fib {
    struct FIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIB>(arg0, 9, b"FIB", b"Fibonacci", b"a simple mathematical formula can manifest in diverse and complex ways", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fce4b0ba512ba311ed66eeeffe7ec83bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

