module 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils {
    public fun build_payload(arg0: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg1: vector<u8>) : vector<u8> {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::new();
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_bytes(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_bytes32(&mut v0, arg0), arg1);
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::to_bytes(v0)
    }

    public fun compute_guid(arg0: u64, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u32, arg4: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::new();
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_bytes32(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_u32(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_bytes32(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_u32(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_u64(&mut v0, arg0), arg1), arg2), arg3), arg4);
        let v1 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::to_bytes(v0);
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(0x2::hash::keccak256(&v1))
    }

    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun transfer_coin_option<T0>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: address) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg0)) {
            transfer_coin<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg0), arg1);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

