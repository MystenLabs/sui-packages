module 0x3784e0ec50d2fb413a2adc100e5d82e63cf67cef975b1bccbeae9fe52271aeb7::bird_entries {
    public fun breakEgg(arg0: address, arg1: u64, arg2: u128, arg3: &vector<u8>, arg4: &mut 0x3784e0ec50d2fb413a2adc100e5d82e63cf67cef975b1bccbeae9fe52271aeb7::bird::BirdStore, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3784e0ec50d2fb413a2adc100e5d82e63cf67cef975b1bccbeae9fe52271aeb7::bird::breakEgg(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun change_admin(arg0: 0x3784e0ec50d2fb413a2adc100e5d82e63cf67cef975b1bccbeae9fe52271aeb7::bird::BirdAdminCap, arg1: address, arg2: &mut 0x3784e0ec50d2fb413a2adc100e5d82e63cf67cef975b1bccbeae9fe52271aeb7::version::Version) {
        0x3784e0ec50d2fb413a2adc100e5d82e63cf67cef975b1bccbeae9fe52271aeb7::bird::change_admin(arg0, arg1, arg2);
    }

    public fun checkIn(arg0: address, arg1: u64, arg2: u128, arg3: &vector<u8>, arg4: &mut 0x3784e0ec50d2fb413a2adc100e5d82e63cf67cef975b1bccbeae9fe52271aeb7::bird::BirdStore, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x3784e0ec50d2fb413a2adc100e5d82e63cf67cef975b1bccbeae9fe52271aeb7::bird::checkIn(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_validator(arg0: &0x3784e0ec50d2fb413a2adc100e5d82e63cf67cef975b1bccbeae9fe52271aeb7::bird::BirdAdminCap, arg1: address, arg2: &mut 0x3784e0ec50d2fb413a2adc100e5d82e63cf67cef975b1bccbeae9fe52271aeb7::bird::Validator, arg3: &mut 0x3784e0ec50d2fb413a2adc100e5d82e63cf67cef975b1bccbeae9fe52271aeb7::version::Version) {
        0x3784e0ec50d2fb413a2adc100e5d82e63cf67cef975b1bccbeae9fe52271aeb7::bird::set_validator(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

