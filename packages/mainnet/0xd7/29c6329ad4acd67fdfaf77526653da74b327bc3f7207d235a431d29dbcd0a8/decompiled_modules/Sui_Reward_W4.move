module 0xd729c6329ad4acd67fdfaf77526653da74b327bc3f7207d235a431d29dbcd0a8::Sui_Reward_W4 {
    struct SUI_REWARD_W4 has drop {
        dummy_field: bool,
    }

    struct SUI_REWARD has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
    }

    public entry fun GiveReward(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = SUI_REWARD{
                id        : 0x2::object::new(arg1),
                image_url : 0x1::string::utf8(b"ipfs://QmQFDETNAjCyZ8JtCuJkrzaWr8MMiuSbNX5G5CXL3cDbAV"),
            };
            0x2::transfer::public_transfer<SUI_REWARD>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: SUI_REWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let SUI_REWARD {
            id        : v0,
            image_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: SUI_REWARD_W4, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Reward"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmQFDETNAjCyZ8JtCuJkrzaWr8MMiuSbNX5G5CXL3cDbAV"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui"));
        let v4 = 0x2::package::claim<SUI_REWARD_W4>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SUI_REWARD>(&v4, v0, v2, arg1);
        0x2::display::update_version<SUI_REWARD>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SUI_REWARD>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

