module 0x663e9debd1356523efc6d08a089f60a89e5c1d084f94cf36e4a8449660c6d85::wct {
    struct WCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCT>(arg0, 6, b"WCT", b"WalletConnect", b"WalletConnect Network is evolving into a permissionless ecosystem powered by WalletConnect Token (WCT) and a community of 35 million users. Backed by major global node operators such as Consensys, Reown, Ledger, Kiln, Figment, Everstake, Arc, and Nansen, t", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/455d90bc-2dd0-4782-ae4b-7da4680b1c1a.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

