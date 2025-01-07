module 0xe38c257ccb4d05610bba738799a4daa747f6eda6bc27491e0b26fd18735dac29::issuer {
    struct DriveNFTId has store, key {
        id: 0x2::object::UID,
        nft: 0x2::object::ID,
    }

    fun count_key() : 0x1::string::String {
        0x1::string::utf8(b"liked_count")
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun like(arg0: &mut 0xe38c257ccb4d05610bba738799a4daa747f6eda6bc27491e0b26fd18735dac29::nft::DriveNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(0xe38c257ccb4d05610bba738799a4daa747f6eda6bc27491e0b26fd18735dac29::nft::uid_mut_as_owner(arg0), count_key());
        *v0 = *v0 + 1;
        0x1::vector::push_back<address>(0x2::dynamic_field::borrow_mut<0x1::string::String, vector<address>>(0xe38c257ccb4d05610bba738799a4daa747f6eda6bc27491e0b26fd18735dac29::nft::uid_mut_as_owner(arg0), liked_key()), 0x2::tx_context::sender(arg1));
    }

    fun liked_key() : 0x1::string::String {
        0x1::string::utf8(b"liked_by")
    }

    public entry fun mint(arg0: &0x2::clock::Clock, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe38c257ccb4d05610bba738799a4daa747f6eda6bc27491e0b26fd18735dac29::nft::new(arg1, arg2, arg3, arg0, arg4);
        0x2::dynamic_field::add<0x1::string::String, u64>(0xe38c257ccb4d05610bba738799a4daa747f6eda6bc27491e0b26fd18735dac29::nft::uid_mut_as_owner(&mut v0), count_key(), 0);
        0x2::dynamic_field::add<0x1::string::String, vector<address>>(0xe38c257ccb4d05610bba738799a4daa747f6eda6bc27491e0b26fd18735dac29::nft::uid_mut_as_owner(&mut v0), liked_key(), 0x1::vector::empty<address>());
        let v1 = DriveNFTId{
            id  : 0x2::object::new(arg4),
            nft : 0x2::object::id<0xe38c257ccb4d05610bba738799a4daa747f6eda6bc27491e0b26fd18735dac29::nft::DriveNFT>(&v0),
        };
        0x2::transfer::public_share_object<0xe38c257ccb4d05610bba738799a4daa747f6eda6bc27491e0b26fd18735dac29::nft::DriveNFT>(v0);
        0x2::transfer::public_transfer<DriveNFTId>(v1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

