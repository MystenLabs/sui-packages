module 0x3705a6e1489052f5d546fac7c9821357913bb763bf453944baccb98b17aceaf6::eddie {
    struct EDDIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDDIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDDIE>(arg0, 6, b"eddie", b"eddie seal", b"eddie pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/38418/large/eddie_200x200.png?1717481062")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EDDIE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDDIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDDIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

