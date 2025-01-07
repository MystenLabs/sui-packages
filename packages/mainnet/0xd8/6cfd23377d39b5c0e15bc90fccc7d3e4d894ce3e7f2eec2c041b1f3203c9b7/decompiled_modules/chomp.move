module 0xd86cfd23377d39b5c0e15bc90fccc7d3e4d894ce3e7f2eec2c041b1f3203c9b7::chomp {
    struct CHOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMP>(arg0, 6, b"CHOMP", b"CHOMP SUI", x"2057454c434f4d4520544f2043484f4d502e2020535549275320464945524345204c4954544c452046555a5a42414c4c210a54484953204755494e4541205049472753204e4f54204a55535420435554452c0a48452753204845524520544f20524154544c45205448452043414745210a4f52414e474520495320544845204e455720424c55452c0a534f204a4f494e20555320494e20544849532057494c4420444547454e20414456454e545552452e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_00_39_30_01fee541e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

