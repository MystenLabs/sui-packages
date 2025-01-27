module 0x7282fcc193d73d8e4ba573f2a1039489924022db09d56a433c6331de1ef42724::TAR {
    struct TAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAR>(arg0, 9, b"TAR", b"TAR", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TAR>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TAR>>(0x2::coin::mint<TAR>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

