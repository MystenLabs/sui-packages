module 0xa5b9497144db6f8c4248bc33e9f72f699479dcb8729949d494729f9811ad3cd2::ThreeDsui {
    struct THREEDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THREEDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THREEDSUI>(arg0, 9, b"3D", b"3Dsui", b"Memecoin. LP tokens - burned, Smartcontract - immutable. Check everything on creator transactions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeicuep5uo5akzxijf7aztucoj2bba5ucto3gweoppyqz5gudy3kjae.ipfs.nftstorage.link/siqrmw7fyr8.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THREEDSUI>>(v1);
        0x2::coin::mint_and_transfer<THREEDSUI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THREEDSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

