module 0xe054c53d3db26c750dc583f3877e5e4ca334c4f7b7dc7c5238dbefccdd1885a5::cctp_message {
    struct CctpMessage has copy, drop {
        version: u32,
        source_domain: u32,
        destination_domain: u32,
        nonce: u256,
        sender: address,
        recipient: address,
        destination_caller: address,
        min_finality_threshold: u32,
        finality_threshold_executed: u32,
        body_version: u32,
        burn_token: address,
        mint_recipient: address,
        amount: u64,
        message_sender: address,
        max_fee: u256,
        fee_executed: u64,
        expiration_block: u256,
        hook_data: vector<u8>,
    }

    public fun amount(arg0: &CctpMessage) : u64 {
        arg0.amount
    }

    public fun amount_net(arg0: &CctpMessage) : u64 {
        arg0.amount - arg0.fee_executed
    }

    public fun body_version(arg0: &CctpMessage) : u32 {
        arg0.body_version
    }

    public fun burn_token(arg0: &CctpMessage) : address {
        arg0.burn_token
    }

    public fun destination_caller(arg0: &CctpMessage) : address {
        arg0.destination_caller
    }

    public fun destination_domain(arg0: &CctpMessage) : u32 {
        arg0.destination_domain
    }

    public fun expiration_block(arg0: &CctpMessage) : u256 {
        arg0.expiration_block
    }

    public fun fee_executed(arg0: &CctpMessage) : u64 {
        arg0.fee_executed
    }

    public fun finality_threshold_executed(arg0: &CctpMessage) : u32 {
        arg0.finality_threshold_executed
    }

    public(friend) fun from_bytes(arg0: &vector<u8>) : CctpMessage {
        assert!(0x1::vector::length<u8>(arg0) >= 148 + 228, 0);
        let v0 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg0, 148 + 68, 32);
        let v1 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg0, 148 + 164, 32);
        assert!(v0 <= 18446744073709551615, 1);
        assert!(v1 < v0, 2);
        CctpMessage{
            version                     : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg0, 0, 4),
            source_domain               : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg0, 4, 4),
            destination_domain          : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg0, 8, 4),
            nonce                       : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg0, 12, 32),
            sender                      : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 44, 32),
            recipient                   : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 76, 32),
            destination_caller          : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 108, 32),
            min_finality_threshold      : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg0, 140, 4),
            finality_threshold_executed : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg0, 144, 4),
            body_version                : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg0, 148 + 0, 4),
            burn_token                  : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 148 + 4, 32),
            mint_recipient              : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 148 + 36, 32),
            amount                      : (v0 as u64),
            message_sender              : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 148 + 100, 32),
            max_fee                     : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg0, 148 + 132, 32),
            fee_executed                : (v1 as u64),
            expiration_block            : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg0, 148 + 196, 32),
            hook_data                   : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::vector_utils::slice<u8>(arg0, 148 + 228, 0x1::vector::length<u8>(arg0)),
        }
    }

    public fun hook_data(arg0: &CctpMessage) : vector<u8> {
        arg0.hook_data
    }

    public fun max_fee(arg0: &CctpMessage) : u256 {
        arg0.max_fee
    }

    public fun message_sender(arg0: &CctpMessage) : address {
        arg0.message_sender
    }

    public fun min_finality_threshold(arg0: &CctpMessage) : u32 {
        arg0.min_finality_threshold
    }

    public fun mint_recipient(arg0: &CctpMessage) : address {
        arg0.mint_recipient
    }

    public fun nonce(arg0: &CctpMessage) : u256 {
        arg0.nonce
    }

    public fun recipient(arg0: &CctpMessage) : address {
        arg0.recipient
    }

    public fun sender(arg0: &CctpMessage) : address {
        arg0.sender
    }

    public fun source_domain(arg0: &CctpMessage) : u32 {
        arg0.source_domain
    }

    public fun version(arg0: &CctpMessage) : u32 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

