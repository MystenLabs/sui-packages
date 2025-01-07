module 0x1192779fd783f84562543bf51ff6ebb626bf514c8dc90cadfeeea30d04e9062e::sudeng {
    struct SUDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDENG>(arg0, 9, b" SUDENG", b"HIPPO", b"HIPPO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/raidenx-prod/logo/sui/0x8993129d72e733985f7f1a00396cbd055bad6f817fee36576ce483c8bbb8b87b::sudeng::SUDENG.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUDENG>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUDENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDENG>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

