module 0xf7d6bb8069397374e3d9d6c640bb3d597f49ec4dc2802fa3dec9cea89ae64398::wal_exg_rate {
    public fun to_lst(arg0: &mut 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_protocol::BlizzardStaking<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u64) {
        let v0 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_protocol::to_lst_at_epoch<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(arg0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1), arg2, false);
        abort if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::destroy_some<u64>(v0)
        } else {
            0
        }
    }

    public fun to_wal(arg0: &mut 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_protocol::BlizzardStaking<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u64) {
        let v0 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_protocol::to_wal_at_epoch<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(arg0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1), arg2, false);
        abort if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::destroy_some<u64>(v0)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

