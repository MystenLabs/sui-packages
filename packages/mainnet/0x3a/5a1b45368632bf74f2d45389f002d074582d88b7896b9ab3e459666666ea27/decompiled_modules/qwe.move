module 0x3a5a1b45368632bf74f2d45389f002d074582d88b7896b9ab3e459666666ea27::qwe {
    struct QWE has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<QWE>, arg1: 0x2::coin::Coin<QWE>) {
        assert!(false == false, 100);
        0x2::coin::burn<QWE>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<QWE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<QWE>(0x2::coin::supply<QWE>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<QWE>>(0x2::coin::mint<QWE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: QWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWE>(arg0, 5, b"QWE", b"QWE", b"QWE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/Tcv4m1o8nnP2xPhSxkpplIFSaB9FEpAIR9gh_Pa3rMA?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QWE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

