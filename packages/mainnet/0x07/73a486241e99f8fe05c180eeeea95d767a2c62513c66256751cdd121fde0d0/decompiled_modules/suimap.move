module 0x773a486241e99f8fe05c180eeeea95d767a2c62513c66256751cdd121fde0d0::suimap {
    struct SUIMAP has drop {
        dummy_field: bool,
    }

    struct SuimapData has store, key {
        id: 0x2::object::UID,
        current_mint: u64,
        sub_check: u64,
        add_check: u64,
        num_factor: u64,
        dum_factor: u64,
        check_factor: u64,
        fee: u64,
        admin: address,
    }

    struct Suimap has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
        current_id: u64,
        description: 0x1::string::String,
        contents: vector<0x1::string::String>,
        content_size: u64,
    }

    struct MintEvent has copy, drop {
        current_mint: u64,
        suimap: 0x2::object::ID,
    }

    fun init(arg0: SUIMAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIMAP>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://moveordinals.com"));
        let v5 = 0x2::display::new_with_fields<Suimap>(&v0, v1, v3, arg1);
        0x2::display::update_version<Suimap>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Suimap>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = SuimapData{
            id           : 0x2::object::new(arg1),
            current_mint : 0,
            sub_check    : 0,
            add_check    : 0,
            num_factor   : 1681392093,
            dum_factor   : 1703336594,
            check_factor : 21637772,
            fee          : 300000000,
            admin        : @0xd46c4e98e10a37aaffc146dce85fd7c39323dcb7c508817413506572d076b279,
        };
        0x2::transfer::share_object<SuimapData>(v6);
    }

    public entry fun mint(arg0: &mut 0x912e777a94bdfd9befda19c3999eb409d4f53041be8d7a30e668bdfe9bc80370::inscription::InscriptionData, arg1: &mut 0x912e777a94bdfd9befda19c3999eb409d4f53041be8d7a30e668bdfe9bc80370::inscription::Fee, arg2: &mut SuimapData, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        while (arg3 > 0) {
            assert!(arg2.current_mint < (0x2::clock::timestamp_ms(arg5) / 1000 - arg2.num_factor - arg2.sub_check + arg2.add_check) * arg2.check_factor / (arg2.dum_factor - arg2.num_factor) * 100, 0);
            let v0 = num_str(arg2.current_mint);
            0x1::string::append(&mut v0, 0x1::string::utf8(b".suimap"));
            let v1 = 0x1::string::utf8(b"https://api.moveordinals.com/uploads/suimaps/image/");
            0x1::string::append(&mut v1, num_str(arg2.current_mint));
            0x1::string::append(&mut v1, 0x1::string::utf8(b".png"));
            let v2 = Suimap{
                id           : 0x2::object::new(arg6),
                name         : v0,
                url          : v1,
                current_id   : 0x912e777a94bdfd9befda19c3999eb409d4f53041be8d7a30e668bdfe9bc80370::inscription::get_total_inscription(arg0) + 1,
                description  : 0x1::string::utf8(b"Suimap provide you with the capability to have digital ownership of a piece of land on the Sui blockchain, offering you the liberty to build without constraints within the context of a collaborative and community-driven project."),
                contents     : 0x1::vector::empty<0x1::string::String>(),
                content_size : 0x1::string::length(&v1),
            };
            0x912e777a94bdfd9befda19c3999eb409d4f53041be8d7a30e668bdfe9bc80370::inscription::inscribe(arg0, arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, arg2.fee, arg6), 0x2::object::id<Suimap>(&v2), arg6);
            0x2::transfer::public_transfer<Suimap>(v2, 0x2::tx_context::sender(arg6));
            arg2.current_mint = arg2.current_mint + 1;
            arg3 = arg3 - 1;
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun update(arg0: &mut SuimapData, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 0);
        arg0.add_check = arg2;
        arg0.sub_check = arg1;
        arg0.fee = arg3;
    }

    // decompiled from Move bytecode v6
}

