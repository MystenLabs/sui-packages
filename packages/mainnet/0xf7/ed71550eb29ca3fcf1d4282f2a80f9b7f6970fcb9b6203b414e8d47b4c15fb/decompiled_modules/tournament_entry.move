module 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament_entry {
    public entry fun create_tournament_entry(arg0: &mut 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament::TournamentRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: vector<vector<u8>>, arg9: bool, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg8)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg8, v1)));
            v1 = v1 + 1;
        };
        0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament::create_tournament(arg0, 0x1::string::utf8(arg1), 0x1::string::utf8(arg2), arg3, arg4, arg5, arg6, arg7, v0, arg9, arg10, arg11);
    }

    public entry fun end_tournament_entry(arg0: &mut 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament::Tournament, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament::end_tournament(arg0, arg1, arg2);
    }

    public entry fun register_nft_entry(arg0: &mut 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament::Tournament, arg1: address, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament::register_nft(arg0, 0x2::object::id_from_address(arg1), arg2, arg3, arg4);
    }

    public entry fun register_nft_with_image_entry(arg0: &mut 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament::Tournament, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament::register_nft_with_image(arg0, 0x2::object::id_from_address(arg1), 0x1::string::utf8(arg2), arg3, arg4, arg5);
    }

    public entry fun vote_for_nft_entry(arg0: &mut 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament::Tournament, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::tournament::vote_for_nft(arg0, 0x2::object::id_from_address(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

