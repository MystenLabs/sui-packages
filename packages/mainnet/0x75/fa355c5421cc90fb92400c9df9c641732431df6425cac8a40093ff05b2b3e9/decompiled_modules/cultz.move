module 0x75fa355c5421cc90fb92400c9df9c641732431df6425cac8a40093ff05b2b3e9::cultz {
    struct CULTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULTZ>(arg0, 9, b"CULTZ", b"Cult Z", b"A Financial Network With Parallelized Performance. Building the most powerful decentralized financial ecosystem. Performant, accessible, and intuitive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Bluefin_New_Logo_80b8b98ab4.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CULTZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CULTZ>>(0x2::coin::mint<CULTZ>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CULTZ>>(v2);
    }

    // decompiled from Move bytecode v6
}

