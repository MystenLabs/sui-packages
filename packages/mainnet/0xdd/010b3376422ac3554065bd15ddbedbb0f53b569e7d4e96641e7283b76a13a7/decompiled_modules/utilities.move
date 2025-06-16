module 0xdd010b3376422ac3554065bd15ddbedbb0f53b569e7d4e96641e7283b76a13a7::utilities {
    public fun return_owned<T0: store + key>(arg0: vector<T0>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(&arg0)) {
            0x2::transfer::public_share_object<T0>(0x1::vector::pop_back<T0>(&mut arg0));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

