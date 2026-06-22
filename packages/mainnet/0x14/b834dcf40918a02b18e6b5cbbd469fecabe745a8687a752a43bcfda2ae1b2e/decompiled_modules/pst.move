module 0x14b834dcf40918a02b18e6b5cbbd469fecabe745a8687a752a43bcfda2ae1b2e::pst {
    struct PST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PST>(arg0, 4, b"PST", b"PST", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pre-vip.com/icon/pst.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PST>>(0x2::coin::mint<PST>(&mut v2, 21000000000, arg1), @0x1a8af69ec5bf8dab20a2dd1b12c0ebd87ef9a3a68e564e9e28636396812b1626);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PST>>(v2);
    }

    // decompiled from Move bytecode v7
}

