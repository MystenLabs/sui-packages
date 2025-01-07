module 0x3daa40bd2af3a0867f483ea5585de41139286b4aca49dc6963b1c82ea06594df::movexnft3524 {
    struct MOVEXNFT3524 has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    public fun deposit(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = NFT{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"SEND Claim Voucher"),
                description : 0x1::string::utf8(b"This NFT is your voucher for SEND Claim. Do not burn or transfer."),
            };
            0x2::transfer::public_transfer<NFT>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: MOVEXNFT3524, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SEND Claim Voucher"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://coroqi3813.icu/img/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This NFT is your voucher for SEND Claim. Do not burn or transfer."));
        let v4 = 0x2::package::claim<MOVEXNFT3524>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

