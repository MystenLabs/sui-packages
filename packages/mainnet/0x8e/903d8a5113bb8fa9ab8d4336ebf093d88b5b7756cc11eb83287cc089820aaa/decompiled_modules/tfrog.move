module 0x8e903d8a5113bb8fa9ab8d4336ebf093d88b5b7756cc11eb83287cc089820aaa::tfrog {
    struct TFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFROG>(arg0, 6, b"TFROG", b"Turbos Frog", x"46697273742046524f47206f6e20747572626f73210a566963746f72696f75732077617272696f72732077696e20666972737420616e64207468656e20676f20746f207761722c207768696c652064656665617465642077617272696f727320676f20746f2077617220666972737420616e64207468656e207365656b20746f2077696e2e2053756e20547a752c2054686520417274206f66205761722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731074317295.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TFROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

