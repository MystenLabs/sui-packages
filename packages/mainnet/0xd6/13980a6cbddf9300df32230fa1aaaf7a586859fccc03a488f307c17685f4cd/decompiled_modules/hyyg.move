module 0xd613980a6cbddf9300df32230fa1aaaf7a586859fccc03a488f307c17685f4cd::hyyg {
    struct HYYG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYYG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYYG>(arg0, 6, b"Hyyg", b"Hi", b"Gv hy it ubu u", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia4pkh2myuueh5wtpmhmjlgou7gsfbcijwephxgxfvp37srzkemwe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYYG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HYYG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

