module 0x5a583ea201476bdf01162c78ef43a4e30172958755eb9aac6a0da0ec2ef0e295::hash {
    struct HASH has drop {
        dummy_field: bool,
    }

    struct MiningController has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<HASH>,
    }

    public(friend) fun mint(arg0: u64, arg1: address, arg2: &mut MiningController, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::total_supply<HASH>(&arg2.treasury_cap) >= 10000000000000000000) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<HASH>>(0x2::coin::mint<HASH>(&mut arg2.treasury_cap, arg0, arg3), arg1);
    }

    entry fun finalize_registration(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<HASH>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<HASH>(arg0, arg1, arg2);
    }

    fun init(arg0: HASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HASH>(arg0, 9, 0x1::string::utf8(b"HASH"), 0x1::string::utf8(b"Hash"), 0x1::string::utf8(x"4861736820697320746865206e6174697665206173736574206f662048617368204c6179657220e28094206120646563656e7472616c697a65642050726f6f662d6f662d576f726b20696e667261737472756374757265206f7065726174696e67206174207468652062617365206c61796572206f66205375692e204561636820746f6b656e20726570726573656e74732063727970746f67726170686963616c6c7920766572696669656420636f6d7075746174696f6e616c20776f726b2c2066756e6374696f6e696e6720617320746865206d696e696e672072657761726420616e6420612066756e64616d656e74616c206275696c64696e6720626c6f636b20666f7220537569277320646563656e7472616c697a65642065636f6e6f6d792e"), 0x1::string::utf8(b"https://bafkreiflivbu3dwkfgpo34un2hi63hez5oqcdnyolsgvlygjnxrhy3j2qq.ipfs.w3s.link"), arg1);
        let v2 = MiningController{
            id           : 0x2::object::new(arg1),
            treasury_cap : v1,
        };
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HASH>>(0x2::coin_registry::finalize<HASH>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MiningController>(v2);
    }

    // decompiled from Move bytecode v6
}

