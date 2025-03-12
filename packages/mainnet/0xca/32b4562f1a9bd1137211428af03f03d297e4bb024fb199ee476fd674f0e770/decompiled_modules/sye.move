module 0xca32b4562f1a9bd1137211428af03f03d297e4bb024fb199ee476fd674f0e770::sye {
    struct SYE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SYE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SYE>(arg0) + arg1 <= 290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SYE>>(0x2::coin::mint<SYE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYE>(arg0, 6, b"SYE", b"SYE", b"SYE Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/moverUSD.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SYE>>(0x2::coin::mint<SYE>(&mut v2, 290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SYE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

