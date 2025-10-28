module 0x97be9dc32986b0e46ca18c21bd1c3d063a27c7d615df21a3945df2881719e341::outbox {
    struct Outbox<T0: store> has store {
        entries: 0x2::table::Table<OutboxKey, OutboxItem<T0>>,
        rate_limit: 0x97be9dc32986b0e46ca18c21bd1c3d063a27c7d615df21a3945df2881719e341::rate_limit::RateLimitState,
    }

    struct OutboxKey has copy, drop, store {
        id: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32,
    }

    struct OutboxItem<T0> has store {
        release_timestamp: u64,
        released: 0x74a839fa81ff0fa13b75cead71b14ec4e3a3ff29a21c4d72ee6f1d9d246b98f5::bitmap::Bitmap,
        recipient_ntt_manager: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        data: 0x74a839fa81ff0fa13b75cead71b14ec4e3a3ff29a21c4d72ee6f1d9d246b98f5::ntt_manager_message::NttManagerMessage<T0>,
    }

    public fun borrow<T0: store>(arg0: &Outbox<T0>, arg1: OutboxKey) : &OutboxItem<T0> {
        0x2::table::borrow<OutboxKey, OutboxItem<T0>>(&arg0.entries, arg1)
    }

    public fun add<T0: store>(arg0: &mut Outbox<T0>, arg1: OutboxItem<T0>) : OutboxKey {
        let v0 = OutboxKey{id: 0x74a839fa81ff0fa13b75cead71b14ec4e3a3ff29a21c4d72ee6f1d9d246b98f5::ntt_manager_message::get_id<T0>(&arg1.data)};
        0x2::table::add<OutboxKey, OutboxItem<T0>>(&mut arg0.entries, v0, arg1);
        v0
    }

    public(friend) fun new<T0: store>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Outbox<T0> {
        Outbox<T0>{
            entries    : 0x2::table::new<OutboxKey, OutboxItem<T0>>(arg1),
            rate_limit : 0x97be9dc32986b0e46ca18c21bd1c3d063a27c7d615df21a3945df2881719e341::rate_limit::new(arg0),
        }
    }

    public fun get_id(arg0: &OutboxKey) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32 {
        arg0.id
    }

    public fun borrow_data<T0: store>(arg0: &OutboxItem<T0>) : &0x74a839fa81ff0fa13b75cead71b14ec4e3a3ff29a21c4d72ee6f1d9d246b98f5::ntt_manager_message::NttManagerMessage<T0> {
        &arg0.data
    }

    public fun borrow_rate_limit_mut<T0: store>(arg0: &mut Outbox<T0>) : &mut 0x97be9dc32986b0e46ca18c21bd1c3d063a27c7d615df21a3945df2881719e341::rate_limit::RateLimitState {
        &mut arg0.rate_limit
    }

    public fun borrow_recipient_ntt_manager_address<T0: store>(arg0: &OutboxItem<T0>) : &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        &arg0.recipient_ntt_manager
    }

    public fun new_outbox_item<T0>(arg0: u64, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg2: 0x74a839fa81ff0fa13b75cead71b14ec4e3a3ff29a21c4d72ee6f1d9d246b98f5::ntt_manager_message::NttManagerMessage<T0>) : OutboxItem<T0> {
        OutboxItem<T0>{
            release_timestamp     : arg0,
            released              : 0x74a839fa81ff0fa13b75cead71b14ec4e3a3ff29a21c4d72ee6f1d9d246b98f5::bitmap::empty(),
            recipient_ntt_manager : arg1,
            data                  : arg2,
        }
    }

    public fun new_outbox_key(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32) : OutboxKey {
        OutboxKey{id: arg0}
    }

    public(friend) fun try_release<T0: store>(arg0: &mut Outbox<T0>, arg1: OutboxKey, arg2: u8, arg3: &0x2::clock::Clock) : bool {
        let v0 = 0x2::table::borrow_mut<OutboxKey, OutboxItem<T0>>(&mut arg0.entries, arg1);
        if (v0.release_timestamp > 0x2::clock::timestamp_ms(arg3)) {
            return false
        };
        if (0x74a839fa81ff0fa13b75cead71b14ec4e3a3ff29a21c4d72ee6f1d9d246b98f5::bitmap::get(&v0.released, arg2)) {
            abort 13906834586660241409
        };
        0x74a839fa81ff0fa13b75cead71b14ec4e3a3ff29a21c4d72ee6f1d9d246b98f5::bitmap::enable(&mut v0.released, arg2);
        true
    }

    // decompiled from Move bytecode v6
}

