module 0x4c96cca4b5b559f04d032c8f3416d0e331f40887efd217ed77e81d7d04e4944e::move {
    struct MOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVE>(arg0, 9, b"MOVE", b"Blue Move 2.0", b"New Move Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/Qmdmvjc2pQ77gjbdZG35QLaMFFLBzsdjstDdGeW3vNdtbk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOVE>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

