module 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::scripts {
    public entry fun create_tournament(arg0: &mut 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament::TournamentRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament::create_tournament(arg0, 0x1::string::utf8(arg1), 0x1::string::utf8(arg2), arg3, arg4, arg5, arg6, arg7, 0x1::vector::empty<0x1::string::String>(), false, false, arg8);
    }

    // decompiled from Move bytecode v6
}

