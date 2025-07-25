module 0xb6d2edf2de92aa3058454bdfc43d92c972b2b68a7bea8736d63896b0d4e99136::deed_pack {
    struct DEED_PACK has drop {
        dummy_field: bool,
    }

    struct DeedPack has store, key {
        id: 0x2::object::UID,
        tier: u8,
        minted_at: u64,
    }

    public(friend) fun burn(arg0: DeedPack, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let DeedPack {
            id        : v0,
            tier      : v1,
            minted_at : v2,
        } = arg0;
        let v3 = v0;
        0xb6d2edf2de92aa3058454bdfc43d92c972b2b68a7bea8736d63896b0d4e99136::events::emit_deed_burned(0x2::object::uid_to_address(&v3), v1, v2, arg1, arg2);
        0x2::object::delete(v3);
    }

    fun init(arg0: DEED_PACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"tier"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Deed NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A non-transferable Deed NFT representing ownership in the ecosystem. Tier: {tier}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://deed.example.com/api/image/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{tier}"));
        let v4 = 0x2::package::claim<DEED_PACK>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<DeedPack>(&v4, v0, v2, arg1);
        0x2::display::update_version<DeedPack>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DeedPack>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: address, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DeedPack{
            id        : 0x2::object::new(arg3),
            tier      : arg1,
            minted_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::public_transfer<DeedPack>(v0, arg0);
        0xb6d2edf2de92aa3058454bdfc43d92c972b2b68a7bea8736d63896b0d4e99136::events::emit_minted(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

