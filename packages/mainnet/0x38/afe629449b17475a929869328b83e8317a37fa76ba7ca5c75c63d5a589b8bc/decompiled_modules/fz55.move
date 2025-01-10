module 0x38afe629449b17475a929869328b83e8317a37fa76ba7ca5c75c63d5a589b8bc::fz55 {
    struct FZ55 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FZ55, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FZ55>(arg0, 6, b"FZ55", b"KodakFZ55", b"My name is $FZ55 . I lay in frozen silence while the world ebbed and flowed like water. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/112313_a9e9ae7a32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FZ55>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FZ55>>(v1);
    }

    // decompiled from Move bytecode v6
}

