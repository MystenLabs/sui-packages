module 0x3ec6708025895d83eceea1d8995648dc87df678dc05f593fb162cd54eecc693b::bdog {
    struct BDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDOG>(arg0, 8, b"BDOG", b"BlueDog", b"BlueDog meme coin on BlueMove", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JMhAkZX.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BDOG>(&mut v2, 35000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

