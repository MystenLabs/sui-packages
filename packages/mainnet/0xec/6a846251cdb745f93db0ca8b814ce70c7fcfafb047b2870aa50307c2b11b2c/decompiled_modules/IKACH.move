module 0xec6a846251cdb745f93db0ca8b814ce70c7fcfafb047b2870aa50307c2b11b2c::IKACH {
    struct IKACH has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<IKACH>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0x953b3f0b6984bc27336502f2ca60df135a5b9e89ff6122055b524cdc39576aec || 0x2::tx_context::sender(arg2) == @0x953b3f0b6984bc27336502f2ca60df135a5b9e89ff6122055b524cdc39576aec, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<IKACH>>(arg0, arg1);
    }

    fun init(arg0: IKACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKACH>(arg0, 9, b"IKACH", b"IkaChan", b"Ikachan loves you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://tan-hidden-shark-534.mypinata.cloud/ipfs/bafkreihmekpthxfpix7ah4d5g2xinaja7virji53tv6dfdy5iypt65nghm")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<IKACH>>(0x2::coin::mint<IKACH>(&mut v2, 1000000000000000000, arg1), @0x953b3f0b6984bc27336502f2ca60df135a5b9e89ff6122055b524cdc39576aec);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IKACH>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKACH>>(v1);
    }

    // decompiled from Move bytecode v6
}

