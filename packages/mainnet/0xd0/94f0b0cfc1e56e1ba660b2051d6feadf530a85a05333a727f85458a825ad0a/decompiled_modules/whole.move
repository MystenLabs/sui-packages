module 0xd094f0b0cfc1e56e1ba660b2051d6feadf530a85a05333a727f85458a825ad0a::whole {
    struct WHOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHOLE>(arg0, 6, b"Whole", b"Whole Mars", x"436f766572696e6720746563682c206d61726b6574732c2041492c206e657720656e657267792c20616e64206175746f6e6f6d6f757320656c6563747269632076656869636c65732032342f370a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_Ocz0cvu_400x400_0c73ba8e58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

