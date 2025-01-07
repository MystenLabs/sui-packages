module 0xfea620a9a223e5bfa580f5c55a3d169f8c03d22e8a7871d3d22a469467fbb4de::jobcat {
    struct JOBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOBCAT>(arg0, 6, b"JOBCAT", b"JOB CAT SUI", b"MARKET FUCK EVEN CATS NEEDS TO WORK, PUMP IN OR GET A JOB LIKE THAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_21_08_03_47_ed77061955.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOBCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

