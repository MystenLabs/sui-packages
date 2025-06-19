module 0x80a69029ab2ff91970b8f265a7c6f28978afa1b315f75ab0f41d98a085236856::xtn {
    struct XTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XTN>(arg0, 6, b"XTN", b"X Token", b"It's test token!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/e78accd8-5dff-44f9-aba4-33e785cce869.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XTN>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XTN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

