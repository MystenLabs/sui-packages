module 0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::burn_message {
    struct BurnMessage has copy, drop {
        version: u32,
        burn_token: address,
        mint_recipient: address,
        amount: u256,
        message_sender: address,
    }

    public fun amount(arg0: &BurnMessage) : u256 {
        arg0.amount
    }

    public fun burn_token(arg0: &BurnMessage) : address {
        arg0.burn_token
    }

    public fun from_bytes(arg0: &vector<u8>) : BurnMessage {
        validate_raw_message(arg0);
        BurnMessage{
            version        : 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::deserialize::deserialize_u32_be(arg0, 0, 4),
            burn_token     : 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::deserialize::deserialize_address(arg0, 4, 32),
            mint_recipient : 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::deserialize::deserialize_address(arg0, 36, 32),
            amount         : 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::deserialize::deserialize_u256_be(arg0, 68, 32),
            message_sender : 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::deserialize::deserialize_address(arg0, 100, 32),
        }
    }

    public fun message_sender(arg0: &BurnMessage) : address {
        arg0.message_sender
    }

    public fun mint_recipient(arg0: &BurnMessage) : address {
        arg0.mint_recipient
    }

    public fun new(arg0: u32, arg1: address, arg2: address, arg3: u256, arg4: address) : BurnMessage {
        BurnMessage{
            version        : arg0,
            burn_token     : arg1,
            mint_recipient : arg2,
            amount         : arg3,
            message_sender : arg4,
        }
    }

    public fun serialize(arg0: &BurnMessage) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::serialize::serialize_u32_be(arg0.version));
        0x1::vector::append<u8>(&mut v0, 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::serialize::serialize_address(arg0.burn_token));
        0x1::vector::append<u8>(&mut v0, 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::serialize::serialize_address(arg0.mint_recipient));
        0x1::vector::append<u8>(&mut v0, 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::serialize::serialize_u256_be(arg0.amount));
        0x1::vector::append<u8>(&mut v0, 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::serialize::serialize_address(arg0.message_sender));
        v0
    }

    public(friend) fun update_mint_recipient(arg0: &mut BurnMessage, arg1: address) {
        arg0.mint_recipient = arg1;
    }

    public(friend) fun update_version(arg0: &mut BurnMessage, arg1: u32) {
        arg0.version = arg1;
    }

    fun validate_raw_message(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 132, 0);
    }

    public fun version(arg0: &BurnMessage) : u32 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

