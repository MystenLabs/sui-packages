module 0x2::tx_context {
    struct TxContext has drop {
        sender: address,
        tx_hash: vector<u8>,
        epoch: u64,
        epoch_timestamp_ms: u64,
        ids_created: u64,
    }

    native fun derive_id(arg0: vector<u8>, arg1: u64) : address;
    public fun digest(arg0: &TxContext) : &vector<u8> {
        &arg0.tx_hash
    }

    public fun epoch(arg0: &TxContext) : u64 {
        native_epoch()
    }

    public fun epoch_timestamp_ms(arg0: &TxContext) : u64 {
        native_epoch_timestamp_ms()
    }

    native fun fresh_id() : address;
    public fun fresh_object_address(arg0: &mut TxContext) : address {
        fresh_id()
    }

    fun ids_created(arg0: &TxContext) : u64 {
        native_ids_created()
    }

    native fun native_epoch() : u64;
    native fun native_epoch_timestamp_ms() : u64;
    native fun native_gas_budget() : u64;
    native fun native_gas_price() : u64;
    native fun native_ids_created() : u64;
    native fun native_sender() : address;
    native fun native_sponsor() : vector<address>;
    fun option_sponsor() : 0x1::option::Option<address> {
        let v0 = native_sponsor();
        if (0x1::vector::length<address>(&v0) == 0) {
            0x1::option::none<address>()
        } else {
            0x1::option::some<address>(*0x1::vector::borrow<address>(&v0, 0))
        }
    }

    public fun sender(arg0: &TxContext) : address {
        native_sender()
    }

    public fun sponsor(arg0: &TxContext) : 0x1::option::Option<address> {
        option_sponsor()
    }

    // decompiled from Move bytecode v6
}

