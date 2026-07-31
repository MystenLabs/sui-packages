module 0xd8be17c7bcbc92cc57a737d60f1a047c5871108789603bdac56ea38d637938d8::transceiver_registry {
    struct TransceiverRegistry has store, key {
        id: 0x2::object::UID,
        next_id: u8,
        enabled_bitmap: 0xcd75c7ff8566b7e5b74ad167f5417128b528ea3215ba69cc7f6f2505047fc0fb::bitmap::Bitmap,
    }

    struct TransceiverInfo has copy, drop, store {
        id: u8,
        state_object_id: 0x2::object::ID,
    }

    struct Key<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun borrow<T0>(arg0: &TransceiverRegistry) : &TransceiverInfo {
        let v0 = Key<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<Key<T0>, TransceiverInfo>(&arg0.id, v0), 13906834492170960897);
        0x2::dynamic_field::borrow<Key<T0>, TransceiverInfo>(&arg0.id, v0)
    }

    fun add<T0>(arg0: &mut TransceiverRegistry, arg1: u8, arg2: 0x2::object::ID) {
        let v0 = Key<T0>{dummy_field: false};
        let v1 = TransceiverInfo{
            id              : arg1,
            state_object_id : arg2,
        };
        0x2::dynamic_field::add<Key<T0>, TransceiverInfo>(&mut arg0.id, v0, v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : TransceiverRegistry {
        TransceiverRegistry{
            id             : 0x2::object::new(arg0),
            next_id        : 0,
            enabled_bitmap : 0xcd75c7ff8566b7e5b74ad167f5417128b528ea3215ba69cc7f6f2505047fc0fb::bitmap::empty(),
        }
    }

    public fun disable_transceiver(arg0: &mut TransceiverRegistry, arg1: u8) {
        0xcd75c7ff8566b7e5b74ad167f5417128b528ea3215ba69cc7f6f2505047fc0fb::bitmap::disable(&mut arg0.enabled_bitmap, arg1);
    }

    public fun enable_transceiver(arg0: &mut TransceiverRegistry, arg1: u8) {
        0xcd75c7ff8566b7e5b74ad167f5417128b528ea3215ba69cc7f6f2505047fc0fb::bitmap::enable(&mut arg0.enabled_bitmap, arg1);
    }

    public fun get_enabled_transceivers(arg0: &TransceiverRegistry) : 0xcd75c7ff8566b7e5b74ad167f5417128b528ea3215ba69cc7f6f2505047fc0fb::bitmap::Bitmap {
        arg0.enabled_bitmap
    }

    public fun get_next_id(arg0: &TransceiverRegistry) : u8 {
        arg0.next_id
    }

    public fun next_id(arg0: &mut TransceiverRegistry) : u8 {
        let v0 = arg0.next_id;
        arg0.next_id = v0 + 1;
        v0
    }

    public fun register_transceiver<T0>(arg0: &mut TransceiverRegistry, arg1: 0x2::object::ID) {
        let v0 = next_id(arg0);
        add<T0>(arg0, v0, arg1);
        enable_transceiver(arg0, v0);
    }

    public fun transceiver_id<T0>(arg0: &TransceiverRegistry) : u8 {
        borrow<T0>(arg0).id
    }

    // decompiled from Move bytecode v7
}

