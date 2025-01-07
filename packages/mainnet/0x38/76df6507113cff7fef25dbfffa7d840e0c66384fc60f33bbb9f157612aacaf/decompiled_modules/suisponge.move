module 0x3876df6507113cff7fef25dbfffa7d840e0c66384fc60f33bbb9f157612aacaf::suisponge {
    struct SUISPONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISPONGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISPONGE>(arg0, 6, b"Suisponge", b"Suisponge", b"Suisponge pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fid.lovepik.com%2Fimage-401330481%2Fsponge-cartoon-character.html&psig=AOvVaw1MvB1O-3hDa2hBMboEZro9&ust=1728909541212000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCODvjI-wi4kDFQAAAAAdAAAAABAE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISPONGE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISPONGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISPONGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

