module 0x61042bffda26b8c3457acf0dfbecc995de95eb46a59cd685c162434cf5623b6d::khanhtest {
    struct KHANHTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHANHTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHANHTEST>(arg0, 9, b"khanhtest", b"khanhname", b"okokokok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"kokokoko")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KHANHTEST>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHANHTEST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KHANHTEST>>(v2);
    }

    // decompiled from Move bytecode v6
}

