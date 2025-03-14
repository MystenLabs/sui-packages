module 0x49a2a61f629fb9b18cdbfcc952d533537be9804f8ebd73ba4bcbbc677da8e621::sue {
    struct SUE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SUE>(arg0) + arg1 <= 1290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUE>>(0x2::coin::mint<SUE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUE>(arg0, 6, b"SUE", b"SUE", b"SUE Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/moverUSD.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUE>>(0x2::coin::mint<SUE>(&mut v2, 1290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

