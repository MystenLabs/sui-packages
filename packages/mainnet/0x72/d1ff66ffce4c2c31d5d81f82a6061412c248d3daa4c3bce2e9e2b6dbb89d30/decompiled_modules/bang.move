module 0x72d1ff66ffce4c2c31d5d81f82a6061412c248d3daa4c3bce2e9e2b6dbb89d30::bang {
    struct BANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANG>(arg0, 9, b"BANG", b"Bang Me Now", b"The most explosive token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.app.goo.gl/kruAjSeyxqWzDc997")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BANG>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

