module 0x57bc2bc975b50b5c767c1fea43189f6aaa7effd9a4095a3af873b03b0e331c88::tkn {
    struct TKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKN>(arg0, 9, b"TKN", b"T Token", b"Token Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.flaticon.com%2Ffree-icon%2Fprofile_3135715&psig=AOvVaw1j1i1FY_vyu0Im2WQnEZ5b&ust=1711428901055000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCNDUkc_PjoUDFQAAAAAdAAAAABAJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TKN>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

