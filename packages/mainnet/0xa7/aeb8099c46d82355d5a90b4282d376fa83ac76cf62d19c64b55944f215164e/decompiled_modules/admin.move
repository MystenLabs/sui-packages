module 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeePercentageUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        updated_by: address,
        timestamp: u64,
    }

    public fun generate_droplet_id(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        let v1 = 0x2::tx_context::fresh_object_address(arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x2::hash::keccak256(&v0);
        let v3 = b"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        let v4 = b"";
        let v5 = 0;
        while (v5 < 6) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v3, (*0x1::vector::borrow<u8>(&v2, v5) as u64) % 36));
            v5 = v5 + 1;
        };
        0x1::string::utf8(v4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun set_fee_percentage(arg0: &AdminCap, arg1: &mut 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::DropletRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 1000, 10);
        0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::set_fee_percentage_internal(arg1, arg2);
        let v0 = FeePercentageUpdated{
            old_fee    : 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::fee_percentage(arg1),
            new_fee    : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeePercentageUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

