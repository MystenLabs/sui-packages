module 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::burn_message {
    struct BurnMessage has copy, drop {
        version: u32,
        burn_token: address,
        mint_recipient: address,
        amount: u256,
        message_sender: address,
        max_fee: u256,
        fee_executed: u256,
        expiration_block: u256,
        hook_data: vector<u8>,
    }

    public fun serialize(arg0: &BurnMessage) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u32_be(arg0.version));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_address(arg0.burn_token));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_address(arg0.mint_recipient));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u256_be(arg0.amount));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_address(arg0.message_sender));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u256_be(arg0.max_fee));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u256_be(arg0.fee_executed));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u256_be(arg0.expiration_block));
        0x1::vector::append<u8>(&mut v0, arg0.hook_data);
        v0
    }

    public fun amount(arg0: &BurnMessage) : u256 {
        arg0.amount
    }

    public fun burn_token(arg0: &BurnMessage) : address {
        arg0.burn_token
    }

    public fun expiration_block(arg0: &BurnMessage) : u256 {
        arg0.expiration_block
    }

    public fun fee_executed(arg0: &BurnMessage) : u256 {
        arg0.fee_executed
    }

    public(friend) fun from_bytes(arg0: &vector<u8>) : BurnMessage {
        validate_raw_message(arg0);
        BurnMessage{
            version          : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg0, 0, 4),
            burn_token       : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 4, 32),
            mint_recipient   : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 36, 32),
            amount           : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg0, 68, 32),
            message_sender   : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 100, 32),
            max_fee          : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg0, 132, 32),
            fee_executed     : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg0, 164, 32),
            expiration_block : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg0, 196, 32),
            hook_data        : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::vector_utils::slice<u8>(arg0, 228, 0x1::vector::length<u8>(arg0)),
        }
    }

    public fun hook_data(arg0: &BurnMessage) : vector<u8> {
        arg0.hook_data
    }

    public fun max_fee(arg0: &BurnMessage) : u256 {
        arg0.max_fee
    }

    public fun message_sender(arg0: &BurnMessage) : address {
        arg0.message_sender
    }

    public fun mint_recipient(arg0: &BurnMessage) : address {
        arg0.mint_recipient
    }

    public(friend) fun new(arg0: u32, arg1: address, arg2: address, arg3: u256, arg4: address, arg5: u256, arg6: vector<u8>) : BurnMessage {
        BurnMessage{
            version          : arg0,
            burn_token       : arg1,
            mint_recipient   : arg2,
            amount           : arg3,
            message_sender   : arg4,
            max_fee          : arg5,
            fee_executed     : 0,
            expiration_block : 0,
            hook_data        : arg6,
        }
    }

    fun validate_raw_message(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) >= 228, 0);
    }

    public fun version(arg0: &BurnMessage) : u32 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

