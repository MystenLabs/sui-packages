module 0x6a26032dc30db017c636e27af84e6821906307e72802260280aca7f1fb5c896b::cjsky {
    struct CJSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CJSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CJSKY>(arg0, 9, b"CJSKY", b"cjsky", b"cjsky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxj5gx37b3fothpvnd74uv5ji74j7lwjrczetl25ldkkktxr6tgy?X-Algorithm=PINATA1&X-Date=1736720030&X-Expires=315360000&X-Method=GET&X-Signature=01954adca7f2d16c50c9bae9a1d470fe498b01bd4d94d62031634805a21432f7"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CJSKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CJSKY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CJSKY>>(v2);
    }

    // decompiled from Move bytecode v6
}

