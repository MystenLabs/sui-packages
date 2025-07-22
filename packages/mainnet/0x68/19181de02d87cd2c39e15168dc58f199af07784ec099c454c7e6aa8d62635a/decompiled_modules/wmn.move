module 0x6819181de02d87cd2c39e15168dc58f199af07784ec099c454c7e6aa8d62635a::wmn {
    struct WMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMN>(arg0, 6, b"WMN", b"WOMEN", b"WOMEN OF THE SUINETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihc6g5qfm6bc4hbhilxwattxc6ndbpc5acxsdaoewsrjak7kl7zui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WMN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

