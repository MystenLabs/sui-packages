module 0x188e96d8bccb3b4eaf375822f03308a9233fe953395884daf34a66ba0eb8705::managenft {
    entry fun batch_burn<T0: store + key>(arg0: vector<T0>) {
        assert!(!0x1::vector::is_empty<T0>(&arg0), 0);
        while (!0x1::vector::is_empty<T0>(&arg0)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg0), @0x0);
        };
        0x1::vector::destroy_empty<T0>(arg0);
    }

    entry fun batch_transfer<T0: store + key>(arg0: vector<T0>, arg1: address) {
        while (!0x1::vector::is_empty<T0>(&arg0)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg0), arg1);
        };
        0x1::vector::destroy_empty<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

