module 0xdd31b6caf727cde37c2d54550745ccefd57411d76308233213d94169cba2c55e::ash {
    struct ASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASH>(arg0, 9, b"ASH", b"Ash ", b"Gotta catch em all!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.gemoo.com/share/image-annotation/610039180365197312?codeId=M0B9g1lxVNBro")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASH>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

