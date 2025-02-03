module 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::volume_control {
    struct EpochLengthUpdatedEvent has copy, drop {
        epoch_length: u64,
    }

    struct VolumeControlState has key {
        id: 0x2::object::UID,
        epoch_length: u64,
        epoch_volumes: 0x2::table::Table<0x1::string::String, u64>,
        last_op_timestamps: 0x2::table::Table<0x1::string::String, u64>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VolumeControlState{
            id                 : 0x2::object::new(arg0),
            epoch_length       : 1800,
            epoch_volumes      : 0x2::table::new<0x1::string::String, u64>(arg0),
            last_op_timestamps : 0x2::table::new<0x1::string::String, u64>(arg0),
        };
        0x2::transfer::share_object<VolumeControlState>(v0);
    }

    public entry fun set_epoch_length(arg0: &0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::AdminState, arg1: u64, arg2: &mut VolumeControlState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager::is_governor(0x2::tx_context::sender(arg3), arg0), 6003);
        arg2.epoch_length = arg1;
        let v0 = EpochLengthUpdatedEvent{epoch_length: arg1};
        0x2::event::emit<EpochLengthUpdatedEvent>(v0);
    }

    public(friend) fun update_volume(arg0: 0x1::string::String, arg1: &u64, arg2: &u64, arg3: &mut VolumeControlState, arg4: &0x2::clock::Clock) {
        if (*arg2 == 0) {
            return
        };
        if (arg3.epoch_length == 0) {
            return
        };
        if (0x2::table::contains<0x1::string::String, u64>(&arg3.epoch_volumes, arg0) == false) {
            0x2::table::add<0x1::string::String, u64>(&mut arg3.epoch_volumes, arg0, 0);
        };
        let v0 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg3.epoch_volumes, arg0);
        if (0x2::table::contains<0x1::string::String, u64>(&arg3.last_op_timestamps, arg0) == false) {
            0x2::table::add<0x1::string::String, u64>(&mut arg3.last_op_timestamps, arg0, 0);
        };
        let v1 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg3.last_op_timestamps, arg0);
        let v2 = 0x2::clock::timestamp_ms(arg4) / 1000;
        if (*v1 < v2 / arg3.epoch_length * arg3.epoch_length) {
            *v0 = *arg1;
        } else {
            *v0 = *v0 + *arg1;
        };
        assert!(*v0 <= *arg2, 6001);
        *v1 = v2;
    }

    // decompiled from Move bytecode v6
}

