module 0xa3f09d7cd2fa5de618cc9c546a4c6d31e61e6595be1838378b7c6dc8fbf39a2f::fre {
    struct FRE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FRE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FRE>>(0x2::coin::mint<FRE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRE>(arg0, 6, b"FRE", b"Freeze", b"freezed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FRE>>(0x2::coin::mint<FRE>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

