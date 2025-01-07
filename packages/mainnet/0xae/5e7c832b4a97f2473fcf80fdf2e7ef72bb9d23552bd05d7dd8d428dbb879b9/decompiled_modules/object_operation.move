module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation {
    struct ObjectTransfer {
        id: 0x2::object::ID,
        to: address,
    }

    struct ObjectTransferToMavenVault {
        id: 0x2::object::ID,
        to_maven_id: 0x2::object::ID,
        to_vault_id: 0x2::object::ID,
    }

    public fun deserialize_object_transfer(arg0: vector<u8>) : ObjectTransfer {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        ObjectTransfer{
            id : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            to : 0x2::bcs::peel_address(&mut v0),
        }
    }

    public fun deserialize_object_transfer_to_maven_vault(arg0: vector<u8>) : ObjectTransferToMavenVault {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        ObjectTransferToMavenVault{
            id          : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            to_maven_id : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            to_vault_id : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
        }
    }

    public fun is_object_transfer(arg0: u64) : bool {
        arg0 == 0
    }

    public fun is_object_transfer_to_maven_vault(arg0: u64) : bool {
        arg0 == 1
    }

    public fun object_transfer_destruct(arg0: ObjectTransfer) : (0x2::object::ID, address) {
        let ObjectTransfer {
            id : v0,
            to : v1,
        } = arg0;
        (v0, v1)
    }

    public fun object_transfer_to_maven_vault_destruct(arg0: ObjectTransferToMavenVault) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        let ObjectTransferToMavenVault {
            id          : v0,
            to_maven_id : v1,
            to_vault_id : v2,
        } = arg0;
        (v0, v1, v2)
    }

    // decompiled from Move bytecode v6
}

