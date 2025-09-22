module 0x63a466797c81218b705c27b0dafdd26cc16d57ed1127dc2bef36e40c9d99a908::adventure_pack {
    struct AdventurePack has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        pack_type: u8,
        rarity: u8,
    }

    struct ADVENTURE_PACK has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: AdventurePack) {
        let AdventurePack {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            pack_type   : _,
            rarity      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun buy_adventure_pack_with_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 50000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 0);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x47efdbc6f87a800909b03bd1e8be6ea1aca2d50ecb95c00c27e289fbaaa67d91);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg1), @0x47efdbc6f87a800909b03bd1e8be6ea1aca2d50ecb95c00c27e289fbaaa67d91);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
        };
        let v1 = mint(0x1::string::utf8(b"Warrior Pack"), 0x1::string::utf8(b"A warrior adventure pack with rare equipment chance"), 0x1::string::utf8(b"https://example.com/warrior-pack.png"), 1, 1, arg1);
        0x2::transfer::public_transfer<AdventurePack>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun description(arg0: &AdventurePack) : &0x1::string::String {
        &arg0.description
    }

    public fun id(arg0: &AdventurePack) : &0x2::object::UID {
        &arg0.id
    }

    public fun image_url(arg0: &AdventurePack) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: ADVENTURE_PACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ADVENTURE_PACK>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://garden-adventure.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Garden Adventure Team"));
        let v5 = 0x2::display::new_with_fields<AdventurePack>(&v0, v1, v3, arg1);
        0x2::display::update_version<AdventurePack>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AdventurePack>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : AdventurePack {
        let v0 = AdventurePack{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            pack_type   : arg3,
            rarity      : arg4,
        };
        0x63a466797c81218b705c27b0dafdd26cc16d57ed1127dc2bef36e40c9d99a908::events::emit_adventure_pack_minted(0x2::object::uid_to_inner(&v0.id), 0x2::tx_context::sender(arg5), arg3, arg4);
        v0
    }

    public fun mint_adventure_pack_free(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<AdventurePack>(mint(0x1::string::utf8(b"Explorer Pack"), 0x1::string::utf8(b"A basic explorer pack with common equipment"), 0x1::string::utf8(b"https://example.com/explorer-pack.png"), 0, 0, arg1), arg0);
    }

    public fun mint_to_sender(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<AdventurePack>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun name(arg0: &AdventurePack) : &0x1::string::String {
        &arg0.name
    }

    public fun pack_type(arg0: &AdventurePack) : u8 {
        arg0.pack_type
    }

    public fun rarity(arg0: &AdventurePack) : u8 {
        arg0.rarity
    }

    // decompiled from Move bytecode v6
}

