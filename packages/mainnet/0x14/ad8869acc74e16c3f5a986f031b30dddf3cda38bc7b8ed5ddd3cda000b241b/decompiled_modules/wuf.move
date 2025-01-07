module 0x14ad8869acc74e16c3f5a986f031b30dddf3cda38bc7b8ed5ddd3cda000b241b::wuf {
    struct WUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUF>(arg0, 9, b"Wuf", b"wuf", b"wuf the cutest doggo on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x883afca4b56fae95817b16ccda40d0d22025ae3f0ef8c5d450d9c0a6ea41f29e::wuf::wuf.png?size=xl&key=4e7ba7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WUF>(&mut v2, 7000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

