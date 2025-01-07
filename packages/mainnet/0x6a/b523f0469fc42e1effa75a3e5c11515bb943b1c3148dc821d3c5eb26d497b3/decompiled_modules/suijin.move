module 0x6ab523f0469fc42e1effa75a3e5c11515bb943b1c3148dc821d3c5eb26d497b3::suijin {
    struct SUIJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJIN>(arg0, 6, b"SIN", b"Suijin", b"Suijin is the Shinto god of water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1745384206006669312/fi1rMGEb_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIJIN>>(v1);
        0x2::coin::mint_and_transfer<SUIJIN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

