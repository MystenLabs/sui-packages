module 0x92f05b1113be877cc04b2fefaff4a46869e9c419bf2756b1937e49efdb6ab073::f {
    struct F has drop {
        dummy_field: bool,
    }

    fun init(arg0: F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F>(arg0, 9, b"F", b"Frogarpus ", b"A chill swamp-dweller with tusks for snacks and webbed paws for vibes. Loves naps, mud baths, and going viral accidentally.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cc4fce74453354b6d4aaac800b8acd18blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<F>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

