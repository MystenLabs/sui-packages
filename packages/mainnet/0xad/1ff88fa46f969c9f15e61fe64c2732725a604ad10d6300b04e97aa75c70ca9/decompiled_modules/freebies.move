module 0xad1ff88fa46f969c9f15e61fe64c2732725a604ad10d6300b04e97aa75c70ca9::freebies {
    struct FREEBIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEBIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREEBIES>(arg0, 9, b"FREEBIES", b"Freebies", b"Collect, Grow, Spend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.beast.taxi/branding/Freebies250.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FREEBIES>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEBIES>>(v2, @0xc9ba0ce754280756b7d00b11ecc7dac1084dfd87a82cfc9e7b469bfe1805f79b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREEBIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

