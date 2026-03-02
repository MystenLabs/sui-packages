module 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::math {
    public(friend) fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

