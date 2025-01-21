module 0xf8776fd8ae1c0ba616dcf6b75c28ff2ddb1bd03afb3890e6ccc3653178f83d3c::zachxbt {
    struct ZACHXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZACHXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZACHXBT>(arg0, 9, b"ZACHXBT", b"Justice for Zachxbt", b"Zachxbt has not been rewarded for all his work on the blockchain, let's help him out by sending this coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmf4M1HDnp69aArNnLAn14Xy8N4b7nSdv6Xn9auYW7dRcq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZACHXBT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZACHXBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZACHXBT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

