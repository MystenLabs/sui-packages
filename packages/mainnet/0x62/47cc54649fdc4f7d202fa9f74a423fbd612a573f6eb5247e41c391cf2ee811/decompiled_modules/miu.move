module 0x32a976482bf4154961bf20bfa3567a80122fdf8e8f8b28d752b609d8640f7846::miu {
    struct MIU has drop {
        dummy_field: bool,
    }

    public entry fun drop_treasury_cap(arg0: 0x2::coin::TreasuryCap<MIU>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIU>>(arg0, @0x0);
    }

    public entry fun drop_upgrade_cap(arg0: 0x2::package::UpgradeCap) {
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg0, @0x0);
    }

    fun init(arg0: MIU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MIU>(arg0, 3, b"MIU", b"MIU", b"MIU, the meme cat coin on the SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://miucoin.io/favicon.ico")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIU>>(v2);
        0x2::coin::mint_and_transfer<MIU>(&mut v3, 900000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIU>>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

