module 0x2e0410c861f40e837ad321a9679286e59cc06c9a2050babbfd55415e937e4d4c::chengine {
    struct CHENGINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENGINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHENGINE>(arg0, 9, untag(b"SCHENGINE"), untag(b"NCHENGINE"), untag(x"444576616e204368656e672069732074686520747261696e2e0a4e6f742064726976696e672069742e0a48652069732074686520747261696e2e0a244348454e47494e4520e280942074686520756e73746f707061626c65204d6f76652d706f7765726564206c6f636f6d6f74697665206f66205375692e0a0a426f726e2066726f6d207468652071756965742067656e6975732077686f206c656674204d6574612c206275696c742074686520656e67696e652c20616e64206e65766572206c6f6f6b6564206261636b2e204e6f2068797065206e65656465642e2054686520747261696e206a757374206b656570732072756e6e696e672e0a486f6c6420244348454e47494e45202d204561726e2024535549"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeigudabrdv7z4354miyh7oaw6dxoardbpb3erkplzjfrrfp5fcwtvq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CHENGINE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CHENGINE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHENGINE>>(0x2::coin::mint<CHENGINE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

