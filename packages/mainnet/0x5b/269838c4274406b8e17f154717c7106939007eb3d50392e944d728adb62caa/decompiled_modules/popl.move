module 0x5b269838c4274406b8e17f154717c7106939007eb3d50392e944d728adb62caa::popl {
    struct POPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPL>(arg0, 6, b"POPL", b"Popplio", b"POPPLIO IS A PINNIPED POKEMON THAT IS PRIMARILY BLUE. IT HAS LARGE EYES, A LONG, WHITE SNOUT WITH BLACK WHISKERS, AND A ROUND, PINK NOSE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibhcvg5s4niiu7v56ksfktglhuzqt3doidoayfrbcgy7kwfj2eul4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POPL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

