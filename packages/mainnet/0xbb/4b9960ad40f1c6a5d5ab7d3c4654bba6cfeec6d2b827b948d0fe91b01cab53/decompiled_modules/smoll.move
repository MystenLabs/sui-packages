module 0xbb4b9960ad40f1c6a5d5ab7d3c4654bba6cfeec6d2b827b948d0fe91b01cab53::smoll {
    struct SMOLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOLL>(arg0, 6, b"SMOLL", b"Smoll Bunny", b"Just a Smoll Bunny with big dreams! Some bunnies are big, but Smoll Bunny is iconic. Think smoll, hop big! Smoll Bunny is hopping to the millies!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smollbunnyprof_e2270c2f12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

