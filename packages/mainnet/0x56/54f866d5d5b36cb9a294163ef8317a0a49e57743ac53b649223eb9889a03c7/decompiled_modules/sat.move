module 0x5654f866d5d5b36cb9a294163ef8317a0a49e57743ac53b649223eb9889a03c7::sat {
    struct SAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAT>(arg0, 6, b"SAT", b"Seal Cat", b"Seal Soul, Cat Vibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_15_02_23_57_8eab845fda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

