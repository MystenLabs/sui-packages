module 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::message {
    struct Message has copy, drop {
        version: u32,
        source_domain: u32,
        destination_domain: u32,
        nonce: u256,
        sender: address,
        recipient: address,
        destination_caller: address,
        min_finality_threshold: u32,
        finality_threshold_executed: u32,
        message_body: vector<u8>,
    }

    public fun destination_caller(arg0: &Message) : address {
        arg0.destination_caller
    }

    public fun destination_domain(arg0: &Message) : u32 {
        arg0.destination_domain
    }

    public fun finality_threshold_executed(arg0: &Message) : u32 {
        arg0.finality_threshold_executed
    }

    public(friend) fun from_bytes(arg0: &vector<u8>) : Message {
        validate_raw_message(arg0);
        Message{
            version                     : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg0, 0, 4),
            source_domain               : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg0, 4, 4),
            destination_domain          : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg0, 8, 4),
            nonce                       : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg0, 12, 32),
            sender                      : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 44, 32),
            recipient                   : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 76, 32),
            destination_caller          : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg0, 108, 32),
            min_finality_threshold      : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg0, 140, 4),
            finality_threshold_executed : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg0, 144, 4),
            message_body                : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::vector_utils::slice<u8>(arg0, 148, 0x1::vector::length<u8>(arg0)),
        }
    }

    public fun message_body(arg0: &Message) : vector<u8> {
        arg0.message_body
    }

    public fun message_body_from_bytes(arg0: &vector<u8>) : vector<u8> {
        validate_raw_message(arg0);
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::vector_utils::slice<u8>(arg0, 148, 0x1::vector::length<u8>(arg0))
    }

    public fun min_finality_threshold(arg0: &Message) : u32 {
        arg0.min_finality_threshold
    }

    public(friend) fun new(arg0: u32, arg1: u32, arg2: u32, arg3: address, arg4: address, arg5: address, arg6: u32, arg7: vector<u8>) : Message {
        Message{
            version                     : arg0,
            source_domain               : arg1,
            destination_domain          : arg2,
            nonce                       : 0,
            sender                      : arg3,
            recipient                   : arg4,
            destination_caller          : arg5,
            min_finality_threshold      : arg6,
            finality_threshold_executed : 0,
            message_body                : arg7,
        }
    }

    public fun nonce(arg0: &Message) : u256 {
        arg0.nonce
    }

    public fun recipient(arg0: &Message) : address {
        arg0.recipient
    }

    public fun sender(arg0: &Message) : address {
        arg0.sender
    }

    public fun serialize(arg0: &Message) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u32_be(arg0.version));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u32_be(arg0.source_domain));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u32_be(arg0.destination_domain));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u256_be(arg0.nonce));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_address(arg0.sender));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_address(arg0.recipient));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_address(arg0.destination_caller));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u32_be(arg0.min_finality_threshold));
        0x1::vector::append<u8>(&mut v0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::serialize::serialize_u32_be(arg0.finality_threshold_executed));
        0x1::vector::append<u8>(&mut v0, arg0.message_body);
        v0
    }

    public fun source_domain(arg0: &Message) : u32 {
        arg0.source_domain
    }

    fun validate_raw_message(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) >= 148, 0);
    }

    public fun version(arg0: &Message) : u32 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

