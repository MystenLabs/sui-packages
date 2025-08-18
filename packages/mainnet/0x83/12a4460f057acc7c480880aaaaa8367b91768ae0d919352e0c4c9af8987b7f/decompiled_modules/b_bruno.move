module 0x8312a4460f057acc7c480880aaaaa8367b91768ae0d919352e0c4c9af8987b7f::b_bruno {
    struct B_BRUNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BRUNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BRUNO>(arg0, 9, b"bBRUNO", b"bToken BRUNO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BRUNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BRUNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

