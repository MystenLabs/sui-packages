module 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::rookiee {
    struct ROOKIEE has drop {
        dummy_field: bool,
    }

    struct Rookiex has store, key {
        id: 0x2::object::UID,
        xid: u128,
        type: u8,
        sub_type: u8,
        rare: u16,
        value: u64,
    }

    struct RookieeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        display: 0x1::option::Option<0x2::display::Display<Rookiex>>,
    }

    public fun burn(arg0: Rookiex) : (u128, u8, u8, u16, u64) {
        let Rookiex {
            id       : v0,
            xid      : v1,
            type     : v2,
            sub_type : v3,
            rare     : v4,
            value    : v5,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3, v4, v5)
    }

    fun init(arg0: ROOKIEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ROOKIEE>(arg0, arg1);
        let v1 = setupNft(&v0, arg1);
        let v2 = Vault{
            id      : 0x2::object::new(arg1),
            display : 0x1::option::some<0x2::display::Display<Rookiex>>(v1),
        };
        let v3 = RookieeAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<Vault>(v2);
        0x2::transfer::public_transfer<RookieeAdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mintTo(arg0: &RookieeAdminCap, arg1: address, arg2: u128, arg3: u8, arg4: u8, arg5: u16, arg6: u64, arg7: &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::checkVersion(arg7, 1);
        let v0 = Rookiex{
            id       : 0x2::object::new(arg8),
            xid      : arg2,
            type     : arg3,
            sub_type : arg4,
            rare     : arg5,
            value    : arg6,
        };
        0x2::transfer::public_transfer<Rookiex>(v0, arg1);
    }

    fun setupNft(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Rookiex> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Rookie Super Collection"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://thebirddogs_api.xyz/nft/{type}/{xid}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://thebirddogs_api.xyz/image/{type}/{sub_type}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://thebirddogs_api.xyz/thumnail/{type}/{sub_type}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The leading memecoin & GameFi Telegram mini-app on the @SuiNetwork"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://x.com/TheBirdsDogs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bird Labs"));
        let v4 = 0x2::display::new_with_fields<Rookiex>(arg0, v0, v2, arg1);
        0x2::display::update_version<Rookiex>(&mut v4);
        v4
    }

    // decompiled from Move bytecode v6
}

