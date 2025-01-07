module 0x3aa4d0295245017441e19ba34f169fe397a932d613cad14419a23b58c0878c29::zxc {
    struct ZXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<ZXC>(arg0, 6, b"ZXC", b"ZXC Token", b"ZXC ZXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreiepkmnmiwdxsvsldfefghfwkr2fzyrtaybfdx5nbmsynbdmppqd6q.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZXC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<ZXC>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<ZXC>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZXC>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

