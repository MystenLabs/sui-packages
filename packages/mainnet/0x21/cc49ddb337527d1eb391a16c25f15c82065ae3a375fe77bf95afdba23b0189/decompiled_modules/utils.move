module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::utils {
    public fun transfer_batch<T0: store + key>(arg0: vector<T0>, arg1: address) {
        0x1::vector::reverse<T0>(&mut arg0);
        while (!0x1::vector::is_empty<T0>(&arg0)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg0), arg1);
        };
        0x1::vector::destroy_empty<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

