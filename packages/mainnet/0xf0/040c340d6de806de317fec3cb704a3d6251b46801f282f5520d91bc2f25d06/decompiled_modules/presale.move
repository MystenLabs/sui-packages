module 0xf0040c340d6de806de317fec3cb704a3d6251b46801f282f5520d91bc2f25d06::presale {
    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        token_metadata: 0x2::coin::CoinMetadata<T0>,
        min_raise: u64,
        max_raise: u64,
        total_raised: u64,
        start_time: u64,
        end_time: u64,
        status: u8,
    }

    // decompiled from Move bytecode v7
}

