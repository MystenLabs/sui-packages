module 0x8e5c3d42b997f0202c8012e12ba223897e9bb51be3d977fdced2c34acc0c9711::efl {
    struct EFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EFL>(arg0, 2, b"EFL", b"EFL$", b"Virtual Sports League", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arivmarketplace.sirv.com/bbn.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EFL>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EFL>>(v2, @0x2a45e366fcdc28761c83fd2ee9ba81c7e7af31d1fba5d80519b0c23e4a1a71cb);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

