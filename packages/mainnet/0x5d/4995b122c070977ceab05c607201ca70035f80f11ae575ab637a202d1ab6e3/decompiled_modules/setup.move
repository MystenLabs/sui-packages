module 0x5d4995b122c070977ceab05c607201ca70035f80f11ae575ab637a202d1ab6e3::setup {
    public entry fun create_state(arg0: &0x2::package::Publisher, arg1: address, arg2: vector<u8>, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x5d4995b122c070977ceab05c607201ca70035f80f11ae575ab637a202d1ab6e3::state::State>(0x5d4995b122c070977ceab05c607201ca70035f80f11ae575ab637a202d1ab6e3::state::new(arg0, arg1, 0x1::string::utf8(arg2), arg3, arg4, arg5));
    }

    // decompiled from Move bytecode v6
}

