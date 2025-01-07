module 0xd08c8b1d4170aa9280039c1e8578863c647ae12fed741e27451b2e7418cd0402::army {
    struct ARMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARMY>(arg0, 9, b"ARMY", b"ARMY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.algonode.xyz/ipfs/Qmdkd7BseX4di7mWYks2KshMmnq6iJFPh1pZbqivBS5kGV")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARMY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARMY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARMY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

