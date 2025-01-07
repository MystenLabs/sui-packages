module 0xab32b8b4059893b47561066319a158f92e1b91f4fb5059d8e08cc917c131172b::DonationCollection {
    struct DonationCollection has key {
        id: 0x2::object::UID,
        supply: u64,
        created: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        percent_to_shelter: u64,
        owner: address,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        donated: u64,
    }

    public entry fun buy_nft(arg0: &mut DonationCollection, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.created < arg0.supply, 0);
        arg0.created = arg0.created + 1;
        let v0 = NFT{
            id      : 0x2::object::new(arg3),
            name    : arg0.name,
            url     : 0x2::url::new_unsafe_from_bytes(arg2),
            donated : arg1,
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun createCollection(arg0: &0xab32b8b4059893b47561066319a158f92e1b91f4fb5059d8e08cc917c131172b::admin::Admin, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4 > 90) {
            arg4 = 90;
        };
        let v0 = DonationCollection{
            id                 : 0x2::object::new(arg6),
            supply             : arg1,
            created            : 0,
            name               : 0x1::string::utf8(arg2),
            description        : 0x1::string::utf8(arg3),
            percent_to_shelter : arg4,
            owner              : arg5,
        };
        0x2::transfer::share_object<DonationCollection>(v0);
    }

    // decompiled from Move bytecode v6
}

