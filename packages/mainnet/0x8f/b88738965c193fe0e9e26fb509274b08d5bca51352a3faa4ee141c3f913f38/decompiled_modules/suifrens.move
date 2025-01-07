module 0x8fb88738965c193fe0e9e26fb509274b08d5bca51352a3faa4ee141c3f913f38::suifrens {
    struct SUIFRENS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIFRENS>, arg1: vector<0x2::coin::Coin<SUIFRENS>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIFRENS>>(&mut arg1);
        0x2::pay::join_vec<SUIFRENS>(&mut v0, arg1);
        0x2::coin::burn<SUIFRENS>(arg0, 0x2::coin::split<SUIFRENS>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIFRENS>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIFRENS>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIFRENS>(v0);
        };
    }

    fun init(arg0: SUIFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmW8N9XaAFZjQpK2Co76BCx5bBnwWoTyXrxJTdsa67i5dr"));
        let (v2, v3) = 0x2::coin::create_currency<SUIFRENS>(arg0, 9, b"FRENS", b"SuiFrens", x"496e2074686520627573746c696e67206469676974616c207265616c6d206f6620626c6f636b636861696e20696e6e6f766174696f6e2c2061206e6577206865726f20656d6572676564e2809453554920465245534e2e20426f726e2066726f6d2074686520706c617966756c20696d6167696e6174696f6e206f66206120636f6d6d756e69747920656167657220746f20626c656e642066696e616e636520776974682066756e2c2053554920465245534e20776173206d6f7265207468616e206a757374206120746f6b656e3b2069742077617320612073796d626f6c206f6620756e6974792c20637265617469766974792c20616e642074686520706f776572206f66206d656d65732e", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFRENS>>(v3);
        0x2::coin::mint_and_transfer<SUIFRENS>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFRENS>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIFRENS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIFRENS>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIFRENS>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIFRENS>>(arg0);
    }

    // decompiled from Move bytecode v6
}

