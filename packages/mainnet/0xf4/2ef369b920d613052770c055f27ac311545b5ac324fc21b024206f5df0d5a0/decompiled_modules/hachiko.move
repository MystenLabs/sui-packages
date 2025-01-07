module 0xf42ef369b920d613052770c055f27ac311545b5ac324fc21b024206f5df0d5a0::hachiko {
    struct HACHIKO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HACHIKO>, arg1: 0x2::coin::Coin<HACHIKO>) {
        0x2::coin::burn<HACHIKO>(arg0, arg1);
    }

    fun init(arg0: HACHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHIKO>(arg0, 9, b"HACHI", b"Hachiko", b"Hachiko is one of the most famous & legendary dog in the world from Japan. Hachiko Memecoin aims to build a lasting legacy in crypto, rewarding loyal supporters and fostering strong community ties.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4amstKcbziHCqwev9esMtRGDTdjHSviiNXT7WtajgjUq.png?size=lg&key=6abe8c")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HACHIKO>>(v1);
        0x2::coin::mint_and_transfer<HACHIKO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HACHIKO>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HACHIKO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HACHIKO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

