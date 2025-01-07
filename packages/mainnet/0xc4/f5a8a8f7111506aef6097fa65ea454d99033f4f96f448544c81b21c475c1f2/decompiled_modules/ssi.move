module 0xc4f5a8a8f7111506aef6097fa65ea454d99033f4f96f448544c81b21c475c1f2::ssi {
    struct SSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSI>(arg0, 9, b"SSI", b"SS", b"SSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSI>(&mut v2, 400000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

