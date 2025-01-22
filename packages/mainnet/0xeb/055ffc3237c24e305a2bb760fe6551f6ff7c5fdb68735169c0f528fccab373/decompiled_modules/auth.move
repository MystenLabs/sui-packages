module 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::auth {
    struct AxelarSigners has store {
        epoch: u64,
        epoch_by_signers_hash: 0x2::table::Table<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, u64>,
        domain_separator: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32,
        minimum_rotation_delay: u64,
        last_rotation_timestamp: u64,
        previous_signers_retention: u64,
    }

    struct MessageToSign has copy, drop, store {
        domain_separator: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32,
        signers_hash: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32,
        data_hash: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AxelarSigners {
        AxelarSigners{
            epoch                      : 0,
            epoch_by_signers_hash      : 0x2::table::new<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, u64>(arg0),
            domain_separator           : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::default(),
            minimum_rotation_delay     : 0,
            last_rotation_timestamp    : 0,
            previous_signers_retention : 0,
        }
    }

    public(friend) fun rotate_signers(arg0: &mut AxelarSigners, arg1: &0x2::clock::Clock, arg2: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::WeightedSigners, arg3: bool) {
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::validate(&arg2);
        update_rotation_timestamp(arg0, arg1, arg3);
        let v0 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::hash(&arg2);
        let v1 = arg0.epoch + 1;
        0x2::table::add<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, u64>(&mut arg0.epoch_by_signers_hash, v0, v1);
        arg0.epoch = v1;
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::events::signers_rotated(v1, v0, arg2);
    }

    public(friend) fun setup(arg0: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, arg1: u64, arg2: u64, arg3: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::WeightedSigners, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : AxelarSigners {
        let v0 = AxelarSigners{
            epoch                      : 0,
            epoch_by_signers_hash      : 0x2::table::new<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, u64>(arg5),
            domain_separator           : arg0,
            minimum_rotation_delay     : arg1,
            last_rotation_timestamp    : 0,
            previous_signers_retention : arg2,
        };
        let v1 = &mut v0;
        rotate_signers(v1, arg4, arg3, false);
        v0
    }

    fun update_rotation_timestamp(arg0: &mut AxelarSigners, arg1: &0x2::clock::Clock, arg2: bool) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(!arg2 || v0 >= arg0.last_rotation_timestamp + arg0.minimum_rotation_delay, 9223372689689804801);
        arg0.last_rotation_timestamp = v0;
    }

    public(friend) fun validate_proof(arg0: &AxelarSigners, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, arg2: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::proof::Proof) : bool {
        let v0 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::hash(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::proof::signers(&arg2));
        let v1 = *0x2::table::borrow<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, u64>(&arg0.epoch_by_signers_hash, v0);
        let v2 = arg0.epoch;
        assert!(v1 != 0 && v2 - v1 <= arg0.previous_signers_retention, 9223372449171767299);
        let v3 = MessageToSign{
            domain_separator : arg0.domain_separator,
            signers_hash     : v0,
            data_hash        : arg1,
        };
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::proof::validate(&arg2, 0x2::bcs::to_bytes<MessageToSign>(&v3));
        v2 == v1
    }

    // decompiled from Move bytecode v6
}

