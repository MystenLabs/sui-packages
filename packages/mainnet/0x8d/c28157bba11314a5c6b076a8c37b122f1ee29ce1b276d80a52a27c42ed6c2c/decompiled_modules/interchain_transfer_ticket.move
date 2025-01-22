module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::interchain_transfer_ticket {
    struct InterchainTransferTicket<phantom T0> {
        token_id: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId,
        balance: 0x2::balance::Balance<T0>,
        source_address: address,
        destination_chain: 0x1::ascii::String,
        destination_address: vector<u8>,
        metadata: vector<u8>,
        version: u64,
    }

    public(friend) fun destroy<T0>(arg0: InterchainTransferTicket<T0>) : (0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, 0x2::balance::Balance<T0>, address, 0x1::ascii::String, vector<u8>, vector<u8>, u64) {
        let InterchainTransferTicket {
            token_id            : v0,
            balance             : v1,
            source_address      : v2,
            destination_chain   : v3,
            destination_address : v4,
            metadata            : v5,
            version             : v6,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public(friend) fun new<T0>(arg0: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: 0x1::ascii::String, arg4: vector<u8>, arg5: vector<u8>, arg6: u64) : InterchainTransferTicket<T0> {
        InterchainTransferTicket<T0>{
            token_id            : arg0,
            balance             : arg1,
            source_address      : arg2,
            destination_chain   : arg3,
            destination_address : arg4,
            metadata            : arg5,
            version             : arg6,
        }
    }

    // decompiled from Move bytecode v6
}

