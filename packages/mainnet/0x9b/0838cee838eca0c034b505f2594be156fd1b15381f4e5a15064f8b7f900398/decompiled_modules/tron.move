module 0x9b0838cee838eca0c034b505f2594be156fd1b15381f4e5a15064f8b7f900398::tron {
    struct TRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRON>(arg0, 9, b"TRON", b"TRON", b"Tron is Base", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.pluggedin.com/wp-content/uploads/2019/12/tron-scaled.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRON>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

