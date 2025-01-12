module 0x972dfd1aea48c7aeca436afb36c0d60e8ebdb61a5a759a1c7fa76cb5b04f295a::cyh {
    struct CYH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYH>(arg0, 9, b"CYH", b"cyh", b"cyh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxj5gx37b3fothpvnd74uv5ji74j7lwjrczetl25ldkkktxr6tgy?X-Algorithm=PINATA1&X-Date=1736719648&X-Expires=315360000&X-Method=GET&X-Signature=adada6794a1b040f687519cf7dcb7c2d67db600bf102422429e883fa95eb7801"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CYH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYH>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CYH>>(v2);
    }

    // decompiled from Move bytecode v6
}

