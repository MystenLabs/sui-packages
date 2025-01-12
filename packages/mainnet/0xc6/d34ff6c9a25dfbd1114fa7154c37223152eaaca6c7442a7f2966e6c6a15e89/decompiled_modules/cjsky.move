module 0xc6d34ff6c9a25dfbd1114fa7154c37223152eaaca6c7442a7f2966e6c6a15e89::cjsky {
    struct CJSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CJSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CJSKY>(arg0, 9, b"CJSKY", b"cjsky", b"cjsky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxj5gx37b3fothpvnd74uv5ji74j7lwjrczetl25ldkkktxr6tgy?X-Algorithm=PINATA1&X-Date=1736722709&X-Expires=315360000&X-Method=GET&X-Signature=ffb570b95f9b5d148afe5af2ed15b033f20d1dc6792855eedade02f060828ef5"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CJSKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CJSKY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CJSKY>>(v2);
    }

    // decompiled from Move bytecode v6
}

