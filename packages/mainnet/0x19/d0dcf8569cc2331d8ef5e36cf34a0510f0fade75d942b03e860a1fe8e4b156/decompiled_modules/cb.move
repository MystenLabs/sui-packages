module 0x19d0dcf8569cc2331d8ef5e36cf34a0510f0fade75d942b03e860a1fe8e4b156::cb {
    struct CB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CB>(arg0, 6, b"CB", b"Cheeseball", x"43686565736562616c6c20636f6e74696e75657320746f2063617374206865616c696e67207370656c6c73207768696c652068697320666f6c6c6f77657273207370726561642074686520776f7264206f662043686565736562616c6c2e0a0a5765206c6f76652043686565736562616c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_234242_574_ad4f9ad329.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CB>>(v1);
    }

    // decompiled from Move bytecode v6
}

