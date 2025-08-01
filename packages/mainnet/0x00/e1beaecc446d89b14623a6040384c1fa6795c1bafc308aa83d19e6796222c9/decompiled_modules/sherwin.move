module 0xe1beaecc446d89b14623a6040384c1fa6795c1bafc308aa83d19e6796222c9::sherwin {
    struct SHERWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHERWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHERWIN>(arg0, 6, b"SHERWIN", b"Sherwin on Sui", b"Hi My name is Sherwin Raglan Caspian Ahab Poseidon Nicodemius Watterson III. My name is quite long but to make it short, my brother darwin told me about the Ocean of sui. Being a blue goldfish is hard, i got bullied for being blue. Let's be friends!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihimig6zsas5unpmfnhmj6bsgas3mvkvucze4l4b2pgvkkfxhdksi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHERWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHERWIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

