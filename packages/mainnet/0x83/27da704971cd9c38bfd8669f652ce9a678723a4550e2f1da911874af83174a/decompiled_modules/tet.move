module 0x8327da704971cd9c38bfd8669f652ce9a678723a4550e2f1da911874af83174a::tet {
    struct TET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TET>(arg0, 6, b"TET", b"SUI TET", x"2253756363657373206973206e6f7420676976656e3b20697427732074616b656e2e20596f75206861766520746f206265206167677265737369766520616e6420676f206166746572207768617420796f752077616e7420696e206c696665220a0a414e4452555720544554", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_TATE_c91fda94e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TET>>(v1);
    }

    // decompiled from Move bytecode v6
}

