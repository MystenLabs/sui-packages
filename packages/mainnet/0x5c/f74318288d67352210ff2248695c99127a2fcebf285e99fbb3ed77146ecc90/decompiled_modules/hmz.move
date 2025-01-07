module 0x5cf74318288d67352210ff2248695c99127a2fcebf285e99fbb3ed77146ecc90::hmz {
    struct HMZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMZ>(arg0, 9, b"HMZ", b"IHateMarkZuckerberg", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tse2.mm.bing.net/th?id=OIP.m8otoiBskOmOqJeg266ODQHaD4&pid=Api&P=0&h=180")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HMZ>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

