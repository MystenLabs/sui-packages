module 0x769fd51e89e8baa97ab56e4f3cab040e06e59b95b836d420988eb7351084ee4a::FLAME {
    struct FLAME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLAME>, arg1: 0x2::coin::Coin<FLAME>) {
        0x2::coin::burn<FLAME>(arg0, arg1);
    }

    fun init(arg0: FLAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAME>(arg0, 2, b"FLAME", b"FLAME", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d1fdloi71mui9q.cloudfront.net/yWduRMdxTbWuSE175lzY_0Uy0NiSvRD8s1av5")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAME>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLAME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FLAME>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

