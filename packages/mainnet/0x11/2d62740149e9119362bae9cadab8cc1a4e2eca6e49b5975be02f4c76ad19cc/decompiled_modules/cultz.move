module 0x112d62740149e9119362bae9cadab8cc1a4e2eca6e49b5975be02f4c76ad19cc::cultz {
    struct CULTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULTZ>(arg0, 9, b"CULTH", b"Cult H", b"A Financial Network With Parallelized Performance. Building the most powerful decentralized financial ecosystem. Performant, accessible, and intuitive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://c.nbsamara.net/sites/nbsamara.net/files/styles/orig_watermark/public/img_1890.png?itok=Y-ry5RzM")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CULTZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CULTZ>>(0x2::coin::mint<CULTZ>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CULTZ>>(v2);
    }

    // decompiled from Move bytecode v6
}

