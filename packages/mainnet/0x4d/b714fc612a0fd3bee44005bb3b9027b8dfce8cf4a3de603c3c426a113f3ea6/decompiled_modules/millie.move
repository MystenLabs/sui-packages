module 0x4db714fc612a0fd3bee44005bb3b9027b8dfce8cf4a3de603c3c426a113f3ea6::millie {
    struct MILLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILLIE>(arg0, 6, b"MILLIE", b"Millie on SUI", b"Millie the dog is the SUI communities best friend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmm_00fd30ceaa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILLIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILLIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

