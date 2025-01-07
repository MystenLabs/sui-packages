module 0x35e47c8bc1d84e302aa511a1c86321bc58e9996cb1308d514c6319739cc81e3a::pap {
    struct PAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAP>(arg0, 9, b"PAP", b"Puff And Pass", b"For The Love Of Weed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

