module 0x8d07f405569485c0044aa737e60096f35f9078b3f3554c748ab1e4bd7e33b8d6::pact_nft {
    struct PactNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        party1: 0x1::string::String,
        party2: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct PactMinted has copy, drop {
        object_id: 0x2::object::ID,
        name: 0x1::string::String,
        party1: 0x1::string::String,
        party2: 0x1::string::String,
    }

    public fun mint_pact(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PactNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            party1      : 0x1::string::utf8(arg2),
            party2      : 0x1::string::utf8(arg3),
            url         : 0x2::url::new_unsafe_from_bytes(arg4),
        };
        let v1 = PactMinted{
            object_id : 0x2::object::id<PactNFT>(&v0),
            name      : v0.name,
            party1    : v0.party1,
            party2    : v0.party2,
        };
        0x2::event::emit<PactMinted>(v1);
        0x2::transfer::public_freeze_object<PactNFT>(v0);
    }

    // decompiled from Move bytecode v7
}

