module 0xb0a521547bb1a5c9f8237280409fd07f6f3f3d8e9f813138538a5026ec96c699::wulfy {
    struct WULFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WULFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WULFY>(arg0, 9, b"WULFY", b"WULFY", x"57554c46592069732074686520756c74696d617465204d454d45206f6e2053756920e2809420746865206f726967696e2c2074686520657373656e63652c2074686520626567696e6e696e6720616e642074686520656e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1870525593420201985/fyBvje3e_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WULFY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WULFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WULFY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

