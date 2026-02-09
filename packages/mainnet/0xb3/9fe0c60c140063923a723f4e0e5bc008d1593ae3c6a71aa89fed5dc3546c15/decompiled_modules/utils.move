module 0xb39fe0c60c140063923a723f4e0e5bc008d1593ae3c6a71aa89fed5dc3546c15::utils {
    public(friend) fun assert_foreign_address_length(arg0: u64, arg1: &vector<u8>) {
        let v0 = if (arg0 == 1) {
            32
        } else {
            20
        };
        assert!(0x1::vector::length<u8>(arg1) == v0, 51);
    }

    public(friend) fun scale_amount(arg0: u256, arg1: u8, arg2: u8) : u256 {
        if (arg2 >= arg1) {
            arg0 * (0x1::u64::pow(10, arg2 - arg1) as u256)
        } else {
            let v1 = (0x1::u64::pow(10, arg1 - arg2) as u256);
            assert!(arg0 % v1 == 0, 33);
            arg0 / v1
        }
    }

    // decompiled from Move bytecode v6
}

