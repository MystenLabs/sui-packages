module 0x9b5956868d7a41b9603b97c16bcd8f43b8f3a850110c11c6b45a2b13ff10eea6::pepitch {
    struct PEPITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPITCH>(arg0, 9, b"PEPITCH", b"Sui Pepitch", x"5045504954434820e28094205468652042697463682074686174206576657279626f64792077616e747321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmdB8w4QioR5fzUiJ5JebdYnSrFcM74ComHk2tniXFdUGc?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPITCH>(&mut v2, 50000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPITCH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

