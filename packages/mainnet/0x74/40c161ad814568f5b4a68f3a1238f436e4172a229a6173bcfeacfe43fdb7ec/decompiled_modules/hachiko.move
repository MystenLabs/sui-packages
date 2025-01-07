module 0x7440c161ad814568f5b4a68f3a1238f436e4172a229a6173bcfeacfe43fdb7ec::hachiko {
    struct HACHIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHIKO>(arg0, 6, b"Hachiko", b"Hachicko", b"Hachik was a Japanese Akita dog remembered for his remarkable loyalty to his owner, Hidesabur Ueno, for whom he continued to wait for over nine years following Ueno's death. Hachik was born on November 10, 1923, at a farm near the city of date, Akita Prefecture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_03_11_40_10_c1f1200c10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

