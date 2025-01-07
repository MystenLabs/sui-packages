module 0xe54f865ec7156452e382a0b0b15c71b0e1c89f1a9bd022553f737528b98af15f::eggy {
    struct EGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGY>(arg0, 9, b"EGGY", b"EGGYYY", b"eggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EGGY>(&mut v2, 2300000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

