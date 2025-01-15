module 0x54fbc04e0919729b2a1d371fc617ea2012f6487c8f1f651a1c4a7811a26fd987::kalilacat {
    struct KALILACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KALILACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KALILACAT>(arg0, 6, b"Kalilacat", b"Kalila cat", b"My soon creat art cat.. Name calila", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000192308_f6805a023a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KALILACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KALILACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

