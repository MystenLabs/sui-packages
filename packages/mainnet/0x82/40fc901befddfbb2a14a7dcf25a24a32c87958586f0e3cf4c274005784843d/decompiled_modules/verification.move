module 0x8240fc901befddfbb2a14a7dcf25a24a32c87958586f0e3cf4c274005784843d::verification {
    public fun create_deposited_inbox_hash(arg0: address, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"deposited");
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(101));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(arg2));
        0x1::hash::sha2_256(v0)
    }

    public fun create_invalidated_inbox_hash(arg0: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"invalidated");
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(101));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::hash::sha2_256(v0)
    }

    public fun create_invalidation_message_hash(arg0: u64, arg1: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(101));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(arg0 / 1000));
        0x1::hash::sha2_256(v0)
    }

    public fun create_swap_message_hash(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: bool) : vector<u8> {
        let v0 = if (arg5) {
            b"buy"
        } else {
            b"sell"
        };
        let v1 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v1, 0x1::string::from_ascii(0x1::type_name::into_string(arg0)));
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(101));
        0x1::vector::append<u8>(&mut v2, 0x2::address::to_bytes(arg4));
        0x1::vector::append<u8>(&mut v2, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(arg3 / 1000));
        0x1::vector::append<u8>(&mut v2, v0);
        0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(v1));
        0x1::vector::append<u8>(&mut v2, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u256_to_be_bytes((arg1 as u256)));
        0x1::vector::append<u8>(&mut v2, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u256_to_be_bytes((arg2 as u256)));
        0x1::hash::sha2_256(v2)
    }

    public fun create_swapped_inbox_hash(arg0: address, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"swapped");
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(101));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(arg2));
        0x1::hash::sha2_256(v0)
    }

    public fun create_sweep_account_created_inbox_hash(arg0: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"sweep_account_created");
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(101));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::hash::sha2_256(v0)
    }

    public fun create_withdrawal_message_hash(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: address, arg4: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v1, 0x1::string::from_ascii(0x1::type_name::into_string(arg0)));
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(101));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg4));
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(arg2 / 1000));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(v1));
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u256_to_be_bytes((arg1 as u256)));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::hash::sha2_256(v0)
    }

    public fun create_withdrew_inbox_hash(arg0: address, arg1: u64, arg2: address, arg3: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"withdrew");
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(101));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::utils::u64_to_be_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::hash::sha2_256(v0)
    }

    // decompiled from Move bytecode v6
}

