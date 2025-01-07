module 0xbd9307b5082ef18385b9818c8d16f37f00074ce95d378cf809cfdd958b105cfa::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 9, b"SB", b"Shark Bee", x"69276d206120536861726b204265652c666c792075702e207468656e2073746f7020627920746f20746865207a6f6f20f09f909df09f92a5f09fa688", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/GbTJ6qCukThcyaydgpgavg5iDsRdoGQ9myNXdZMVmvLP.png?size=xl&key=58ebce")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SB>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SB>>(v1);
    }

    // decompiled from Move bytecode v6
}

