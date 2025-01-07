module 0x3729f7dcb08033122b478eb5ea39e95dd8241089d525242cf435450522061ad2::mz {
    struct MZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MZ>(arg0, 9, b"MZ", b"MAZE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsReFTYPafm8J7AUBncvEUts8G7mAGS_bTHA&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MZ>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

