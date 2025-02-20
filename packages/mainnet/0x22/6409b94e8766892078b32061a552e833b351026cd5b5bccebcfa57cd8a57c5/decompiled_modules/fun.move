module 0x226409b94e8766892078b32061a552e833b351026cd5b5bccebcfa57cd8a57c5::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 9, b"FUN", b"Funky Aura", x"4e6577206779616c20636f6d6520696e746f205355492065636f73797374656d2e204772616220736f6d652c206d616b6520796f75722077616c6c657420696e2066756c6c20736d696c65206c61746572200a0a3b290a29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9171753647bc6d33c67c6b045413e0dablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

