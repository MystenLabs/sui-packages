module 0x6c4fdb44a4337e7d0c2a723c8050539d84ad551e85518a5151f97f4053adb97e::women {
    struct WOMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOMEN>(arg0, 6, b"WOMEN", b"SUI WOMEN", b"sui women are coming to save crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihc6g5qfm6bc4hbhilxwattxc6ndbpc5acxsdaoewsrjak7kl7zui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOMEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

