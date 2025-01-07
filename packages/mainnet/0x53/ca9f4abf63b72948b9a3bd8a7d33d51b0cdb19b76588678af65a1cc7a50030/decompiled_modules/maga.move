module 0x53ca9f4abf63b72948b9a3bd8a7d33d51b0cdb19b76588678af65a1cc7a50030::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 9, b"MAGA", b"TRUMP", b"make 1000x again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s7d2.scene7.com/is/image/TWCNews/trumpgoodyearpetejpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGA>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v2, @0xf77deb5327ad4d5c260ddc86b579c8c5ad50a28e619cc1cd4cb26197eb7060ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

