module 0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::external_address {
    struct ExternalAddress has copy, drop, store {
        value: 0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::bytes32::Bytes32,
    }

    public fun default() : ExternalAddress {
        new(0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::bytes32::default())
    }

    public fun from_address(arg0: address) : ExternalAddress {
        new(0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::bytes32::from_address(arg0))
    }

    public fun is_nonzero(arg0: &ExternalAddress) : bool {
        0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::bytes32::is_nonzero(&arg0.value)
    }

    public fun take_bytes(arg0: &mut 0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::cursor::Cursor<u8>) : ExternalAddress {
        new(0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::bytes32::take_bytes(arg0))
    }

    public fun to_bytes(arg0: ExternalAddress) : vector<u8> {
        0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::bytes32::to_bytes(to_bytes32(arg0))
    }

    public fun from_id(arg0: 0x2::object::ID) : ExternalAddress {
        new(0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::bytes32::from_bytes(0x2::object::id_to_bytes(&arg0)))
    }

    public fun new(arg0: 0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::bytes32::Bytes32) : ExternalAddress {
        ExternalAddress{value: arg0}
    }

    public fun new_nonzero(arg0: 0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::bytes32::Bytes32) : ExternalAddress {
        assert!(0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::bytes32::is_nonzero(&arg0), 0);
        new(arg0)
    }

    public fun take_nonzero(arg0: &mut 0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::cursor::Cursor<u8>) : ExternalAddress {
        new_nonzero(0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::bytes32::take_bytes(arg0))
    }

    public fun to_address(arg0: ExternalAddress) : address {
        0x2::address::from_bytes(to_bytes(arg0))
    }

    public fun to_bytes32(arg0: ExternalAddress) : 0x6d61663325c160812539ddb73b95856aada3be10bc83c55f0d74e47698d72283::bytes32::Bytes32 {
        let ExternalAddress { value: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}

