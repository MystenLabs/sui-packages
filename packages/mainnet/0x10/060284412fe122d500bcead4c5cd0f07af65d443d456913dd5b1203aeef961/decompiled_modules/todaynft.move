module 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft {
    struct TODAYNFT has drop {
        dummy_field: bool,
    }

    struct TodayNFT has store, key {
        id: 0x2::object::UID,
        date: u64,
        name: 0x1::string::String,
        news_blob_id: 0x1::string::String,
        image_blob_id: 0x1::string::String,
        user_description: 0x1::string::String,
    }

    public fun date(arg0: &TodayNFT) : u64 {
        arg0.date
    }

    public fun image_blob_id(arg0: &TodayNFT) : &0x1::string::String {
        &arg0.image_blob_id
    }

    fun init(arg0: TODAYNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TODAYNFT>(arg0, arg1);
        let v1 = 0x2::display::new<TodayNFT>(&v0, arg1);
        0x2::display::add<TodayNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<TodayNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{user_description}"));
        0x2::display::add<TodayNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_blob_id}"));
        0x2::display::update_version<TodayNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<TodayNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TodayNFT>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<TodayNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TodayNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : TodayNFT {
        assert!(0x1::string::length(&arg2) <= 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::config::max_uri_len(), 1);
        assert!(0x1::string::length(&arg3) <= 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::config::max_uri_len(), 1);
        TodayNFT{
            id               : 0x2::object::new(arg4),
            date             : arg0,
            name             : arg1,
            news_blob_id     : arg2,
            image_blob_id    : arg3,
            user_description : 0x1::string::utf8(b""),
        }
    }

    public fun name(arg0: &TodayNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun news_blob_id(arg0: &TodayNFT) : &0x1::string::String {
        &arg0.news_blob_id
    }

    public fun set_description(arg0: &mut TodayNFT, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) <= 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::config::max_text_len(), 2);
        arg0.user_description = arg1;
    }

    public fun set_name(arg0: &mut TodayNFT, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) <= 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::config::max_text_len(), 2);
        arg0.name = arg1;
    }

    public fun user_description(arg0: &TodayNFT) : &0x1::string::String {
        &arg0.user_description
    }

    // decompiled from Move bytecode v7
}

