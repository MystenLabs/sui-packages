module 0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::bird_entries {
    public entry fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::bird::BirdStore, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::bird::action(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun breakEgg(arg0: address, arg1: u64, arg2: u128, arg3: &vector<u8>, arg4: &mut 0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::bird::BirdStore, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::bird::breakEgg(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun change_admin(arg0: 0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::bird::BirdAdminCap, arg1: address, arg2: &mut 0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::version::Version) {
        0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::bird::change_admin(arg0, arg1, arg2);
    }

    public fun checkIn(arg0: address, arg1: u64, arg2: u128, arg3: &vector<u8>, arg4: &mut 0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::bird::BirdStore, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::bird::checkIn(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_validator(arg0: &0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::bird::BirdAdminCap, arg1: address, arg2: &mut 0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::bird::Validator, arg3: &mut 0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::version::Version) {
        0xf603c529cd3c472c8b32f1c59a0bc33d8c9ca9607f0a04dd7cb76e3c5ce43520::bird::set_validator(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

