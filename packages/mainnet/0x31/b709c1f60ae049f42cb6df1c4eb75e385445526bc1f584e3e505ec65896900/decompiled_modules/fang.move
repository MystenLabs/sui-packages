module 0x31b709c1f60ae049f42cb6df1c4eb75e385445526bc1f584e3e505ec65896900::fang {
    struct FANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FANG>(arg0, 6, b"FANG", b"Fuddies Gang", b"Fuddies Gang Official Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_28_07_43_20_29d186ac2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

