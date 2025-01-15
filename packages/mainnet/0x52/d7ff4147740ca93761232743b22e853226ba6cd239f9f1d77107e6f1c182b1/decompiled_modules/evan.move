module 0x52d7ff4147740ca93761232743b22e853226ba6cd239f9f1d77107e6f1c182b1::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVAN>(arg0, 9, b"Evan", b"Evan Cheng", b"Evan Cheng is the CEO and co-founder of Mysten Labs, the company behind Sui blockchain, which develops tools to make web3 secure, reliable, and ready for mass adoption.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/292f1df4edf5a40e78be9abb8d45f53eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

