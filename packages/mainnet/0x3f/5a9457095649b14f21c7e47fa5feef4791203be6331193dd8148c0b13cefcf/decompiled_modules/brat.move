module 0x3f5a9457095649b14f21c7e47fa5feef4791203be6331193dd8148c0b13cefcf::brat {
    struct BRAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BRAT>, arg1: 0x2::coin::Coin<BRAT>) {
        0x2::coin::burn<BRAT>(arg0, arg1);
    }

    public entry fun create(arg0: &mut 0x2::coin::TreasuryCap<BRAT>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BRAT>>(0x2::coin::mint<BRAT>(arg0, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: BRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAT>(arg0, 9, b"BRAT", b"Brat", b"https://www.coinmarketjob.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeib74wiinoepmp7zx37drpzrv2nhep3gncwdyo73v3nczjvanyyume.ipfs.w3s.link/charli-xcx-brat-1709223208%20(1).jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<BRAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BRAT>>(0x2::coin::mint<BRAT>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

