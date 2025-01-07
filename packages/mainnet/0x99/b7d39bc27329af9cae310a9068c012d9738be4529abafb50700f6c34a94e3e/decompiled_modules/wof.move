module 0x99b7d39bc27329af9cae310a9068c012d9738be4529abafb50700f6c34a94e3e::wof {
    struct WOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOF>(arg0, 6, b"Wof", b"Wolf", x"4120776f6c6620646f672067656e746c79206361727279696e6720612070757070792c2073686f77696e6720612070726f7465637469766520616e6420636172696e6720676573747572652e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241014023536_5b5d2b6e8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

