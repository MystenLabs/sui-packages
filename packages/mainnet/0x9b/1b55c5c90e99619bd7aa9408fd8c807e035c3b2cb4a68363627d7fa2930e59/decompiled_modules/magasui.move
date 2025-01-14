module 0x9b1b55c5c90e99619bd7aa9408fd8c807e035c3b2cb4a68363627d7fa2930e59::magasui {
    struct MAGASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGASUI>(arg0, 6, b"MAGASUI", b"MAGA SUI", x"4d4147415355493a2054686520746f6b656e205472756d7020776f756c6420686f646c206966206865206b6e657720776861742063727970746f207761732e204275696c74206f6e20746865207472656d656e646f75736c7920636c6173737920537569204e6574776f726b2c207468697320697320746865206d6f73742059554745206d656d6520746f6b656e20796f75e280996c6c2065766572207365652e0a0af09f92ac20e2809c45766572796f6e65e280997320736179696e672069742e204d4147415355492069732077696e6e696e672e204269676c792ee2809d20e280932050726f6261626c79205472756d702e0a0a4f6e6c79206c6f736572732073656c6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736819787886.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

