module 0xd6c3a4382a7530a1dcccd18008903de37b539c2b619e31846697fc3ed56e61f0::trumpceo {
    struct TRUMPCEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPCEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPCEO>(arg0, 2, b"Trumpceo", b"Trumpceo", b"Trumpceo pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.coingabbar.com%2Fid%2Fcrypto-currency%2Ftrumpceo-trumpceo-prices-usd&psig=AOvVaw06JeZ8A9Fe4XN2Z9zU42YP&ust=1728787769643000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCMj-xLTqh4kDFQAAAAAdAAAAABAE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPCEO>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPCEO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPCEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

