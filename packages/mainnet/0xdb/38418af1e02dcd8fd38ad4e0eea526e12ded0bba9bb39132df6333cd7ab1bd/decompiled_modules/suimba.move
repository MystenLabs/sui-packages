module 0xdb38418af1e02dcd8fd38ad4e0eea526e12ded0bba9bb39132df6333cd7ab1bd::suimba {
    struct SUIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMBA>(arg0, 9, b"SUIMBA", b"Suimba", b"Unleash the LION | Powered by Sui. Half Sui, half Simba, 100% wild.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1841264894047350784/LD5uGQ9r_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMBA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMBA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

