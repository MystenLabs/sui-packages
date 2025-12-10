module 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::hardware_state {
    struct HardwareState has copy, drop {
        device_id: vector<u8>,
        sensor_status: vector<u8>,
        last_event_timestamp: u64,
        battery_level: 0x1::option::Option<u64>,
        signal_strength: 0x1::option::Option<u64>,
    }

    public fun create_hardware_state(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) : HardwareState {
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::is_valid_device_id(&arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_device_id());
        HardwareState{
            device_id            : arg0,
            sensor_status        : arg1,
            last_event_timestamp : arg2,
            battery_level        : 0x1::option::none<u64>(),
            signal_strength      : 0x1::option::none<u64>(),
        }
    }

    public fun create_hardware_state_with_metadata(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>) : HardwareState {
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::is_valid_device_id(&arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_device_id());
        HardwareState{
            device_id            : arg0,
            sensor_status        : arg1,
            last_event_timestamp : arg2,
            battery_level        : arg3,
            signal_strength      : arg4,
        }
    }

    public fun get_device_id(arg0: &HardwareState) : vector<u8> {
        arg0.device_id
    }

    public fun get_last_event_timestamp(arg0: &HardwareState) : u64 {
        arg0.last_event_timestamp
    }

    public fun get_sensor_status(arg0: &HardwareState) : vector<u8> {
        arg0.sensor_status
    }

    public fun is_bin_full(arg0: &HardwareState) : bool {
        let v0 = b"FULL";
        let v1 = get_sensor_status(arg0);
        if (0x1::vector::length<u8>(&v1) == 4) {
            if (*0x1::vector::borrow<u8>(&v1, 0) == *0x1::vector::borrow<u8>(&v0, 0)) {
                if (*0x1::vector::borrow<u8>(&v1, 1) == *0x1::vector::borrow<u8>(&v0, 1)) {
                    if (*0x1::vector::borrow<u8>(&v1, 2) == *0x1::vector::borrow<u8>(&v0, 2)) {
                        *0x1::vector::borrow<u8>(&v1, 3) == *0x1::vector::borrow<u8>(&v0, 3)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun validate_hardware_state(arg0: &HardwareState) : bool {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::is_valid_device_id(&arg0.device_id) && arg0.last_event_timestamp > 0
    }

    // decompiled from Move bytecode v6
}

