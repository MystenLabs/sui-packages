module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation {
    struct CoinTransfer {
        coin: 0x1::ascii::String,
        to: address,
        amount: u64,
    }

    struct CoinTransferToMavenVault {
        coin: 0x1::ascii::String,
        to_maven_id: 0x2::object::ID,
        to_vault_id: 0x2::object::ID,
        amount: u64,
    }

    public fun coin_transfer_destruct(arg0: CoinTransfer) : (0x1::ascii::String, address, u64) {
        let CoinTransfer {
            coin   : v0,
            to     : v1,
            amount : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun coin_transfer_to_maven_vault_destruct(arg0: CoinTransferToMavenVault) : (0x1::ascii::String, 0x2::object::ID, 0x2::object::ID, u64) {
        let CoinTransferToMavenVault {
            coin        : v0,
            to_maven_id : v1,
            to_vault_id : v2,
            amount      : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public fun deserialize_coin_transfer(arg0: vector<u8>) : CoinTransfer {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        CoinTransfer{
            coin   : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            to     : 0x2::bcs::peel_address(&mut v0),
            amount : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun deserialize_coin_transfer_to_maven_vault(arg0: vector<u8>) : CoinTransferToMavenVault {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        CoinTransferToMavenVault{
            coin        : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            to_maven_id : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            to_vault_id : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            amount      : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun is_coin_transfer(arg0: u64) : bool {
        arg0 == 0
    }

    public fun is_coin_transfer_to_maven_vault(arg0: u64) : bool {
        arg0 == 1
    }

    // decompiled from Move bytecode v6
}

