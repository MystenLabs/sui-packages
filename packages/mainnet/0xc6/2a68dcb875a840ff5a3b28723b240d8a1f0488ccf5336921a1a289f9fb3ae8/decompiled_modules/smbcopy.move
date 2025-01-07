module 0xc62a68dcb875a840ff5a3b28723b240d8a1f0488ccf5336921a1a289f9fb3ae8::smbcopy {
    struct SMBCopyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        descripton: 0x1::string::String,
        image_url: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        project_url: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct SMBCOPY has drop {
        dummy_field: bool,
    }

    public entry fun burn_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun burn_copy(arg0: &AdminCap, arg1: SMBCopyNFT) {
        let SMBCopyNFT {
            id            : v0,
            name          : _,
            descripton    : _,
            image_url     : _,
            thumbnail_url : _,
            project_url   : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: SMBCOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{thumbnail_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = 0x2::package::claim<SMBCOPY>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<SMBCopyNFT>(&v5, v0, v2, arg1);
        0x2::display::update_version<SMBCopyNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SMBCopyNFT>>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_copy(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SMBCopyNFT{
            id            : 0x2::object::new(arg5),
            name          : 0x1::string::utf8(arg1),
            descripton    : 0x1::string::utf8(arg2),
            image_url     : 0x1::string::utf8(arg3),
            thumbnail_url : 0x1::string::utf8(arg3),
            project_url   : 0x1::string::utf8(arg4),
        };
        0x2::transfer::public_transfer<SMBCopyNFT>(v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

