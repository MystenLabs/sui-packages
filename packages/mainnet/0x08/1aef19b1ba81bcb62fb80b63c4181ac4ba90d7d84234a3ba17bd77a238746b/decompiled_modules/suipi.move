module 0x81aef19b1ba81bcb62fb80b63c4181ac4ba90d7d84234a3ba17bd77a238746b::suipi {
    struct SUIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPI>(arg0, 6, b"SUIPI", b"SUIPI SUI", b"$SUIPI embark on an icy adventure like no other tands as a distinctive meme token on Sui, boasting a cutest and charming penguin mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/knk_ff22b7ee5b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

