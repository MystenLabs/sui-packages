module 0x9ee487fc9f91f0e3240dbc461e615514e33953d36356872c53fefaa149764ae0::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 9, b"TST", b"TST", b"A shrimp test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=http%3A%2F%2Fwww.timotis.com%2Fnews-1%2Fshrimp-facts&psig=AOvVaw2n3_dmLgv8pn7OKDcu38a-&ust=1739872880902000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIjAq9y5yosDFQAAAAAdAAAAABAE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TST>(&mut v2, 100001000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TST>>(v1);
    }

    // decompiled from Move bytecode v6
}

