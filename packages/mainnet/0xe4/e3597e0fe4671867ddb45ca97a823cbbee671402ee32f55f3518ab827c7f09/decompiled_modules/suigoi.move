module 0xe4e3597e0fe4671867ddb45ca97a823cbbee671402ee32f55f3518ab827c7f09::suigoi {
    struct SUIGOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOI>(arg0, 6, b"SUIGOI", b"Suigoi", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/otaku_encyclopedia/images/6/63/Sugoi_Image.png/revision/latest?cb=20200614200606")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGOI>(&mut v2, 444444444000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

