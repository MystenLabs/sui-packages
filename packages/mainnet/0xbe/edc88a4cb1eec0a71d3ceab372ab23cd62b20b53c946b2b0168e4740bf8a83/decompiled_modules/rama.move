module 0xbeedc88a4cb1eec0a71d3ceab372ab23cd62b20b53c946b2b0168e4740bf8a83::rama {
    struct RAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAMA>(arg0, 6, b"RAMA", b"Rama is the new coin", b"Rama on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hotpot.ai/images/site/ai/photoshoot/avatar/style_gallery/38.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAMA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

