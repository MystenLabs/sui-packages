module 0xdd82b864d6d085a98133656a98b0a19c904e5ab65e33021b0181a8c50101e544::aquagoat {
    struct AQUAGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAGOAT>(arg0, 9, b"AQUAGOAT", b"Aqua Goat", b"AQUA GOAT IS MEME TOKEN NUMBER 01 FROM 2022", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmUctpsEGkRRbZvds85XpV6w9txtYNeMvestXYAmhXCfh5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AQUAGOAT>(&mut v2, 666666000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAGOAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

