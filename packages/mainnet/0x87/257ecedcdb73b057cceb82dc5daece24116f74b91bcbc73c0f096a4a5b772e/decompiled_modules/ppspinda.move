module 0x87257ecedcdb73b057cceb82dc5daece24116f74b91bcbc73c0f096a4a5b772e::ppspinda {
    struct PPSPINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPSPINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPSPINDA>(arg0, 6, b"PPSPINDA", b"POKEMON", b"CHARACTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifvfi5g5ppvh7t7oag6ipabxfewitxshlqyqhyvv7wxjcfuqciyxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPSPINDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PPSPINDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

