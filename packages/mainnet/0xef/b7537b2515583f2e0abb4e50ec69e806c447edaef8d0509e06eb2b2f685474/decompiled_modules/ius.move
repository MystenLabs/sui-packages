module 0xefb7537b2515583f2e0abb4e50ec69e806c447edaef8d0509e06eb2b2f685474::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 6, b"iuS", b"iuS", b"iuS is reversal Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/BfSB0mb/Ava.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IUS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

