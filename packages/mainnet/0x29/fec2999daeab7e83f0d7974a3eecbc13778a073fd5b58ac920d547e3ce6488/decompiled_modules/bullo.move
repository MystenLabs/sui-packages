module 0x29fec2999daeab7e83f0d7974a3eecbc13778a073fd5b58ac920d547e3ce6488::bullo {
    struct BULLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLO>(arg0, 6, b"BULLO", b"BULLO THE BULL", x"444547454e41524154452042554c4c204f4e2053554921210a556e64656e6961626c79202442554c4c4f2e2054686973206973206e6f7420612062756c6c2e205468697320697320544845202442554c4c4f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigqopy3yic4hlxrf75bevrbmmi4fiissracqhdx6ub26h25yi733m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULLO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

