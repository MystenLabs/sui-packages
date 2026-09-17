module 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy {
    struct Toy has store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        issue: u64,
        image_url: 0x2::url::Url,
        video_url: 0x2::url::Url,
        media_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        usd_price: u64,
        points_price: u64,
        total_supply: u64,
        max_supply: u64,
        is_listed: bool,
    }

    public fun attributes(arg0: &Toy) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun create(arg0: 0x1::string::String, arg1: u64, arg2: 0x1::string::String, arg3: 0x2::url::Url, arg4: 0x2::url::Url, arg5: 0x2::url::Url, arg6: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg7: u64, arg8: u64) : Toy {
        Toy{
            name         : arg0,
            description  : arg2,
            issue        : arg1,
            image_url    : arg3,
            video_url    : arg4,
            media_url    : arg5,
            attributes   : arg6,
            usd_price    : arg7,
            points_price : 0,
            total_supply : 0,
            max_supply   : arg8,
            is_listed    : true,
        }
    }

    public fun description(arg0: &Toy) : 0x1::string::String {
        arg0.description
    }

    public fun image_url(arg0: &Toy) : 0x2::url::Url {
        arg0.image_url
    }

    public(friend) fun increase_supply(arg0: &mut Toy, arg1: u64) {
        assert!(arg0.total_supply + arg1 <= arg0.max_supply, 0);
        arg0.total_supply = arg0.total_supply + arg1;
    }

    public fun is_listed(arg0: &Toy) : bool {
        arg0.is_listed
    }

    public fun issue(arg0: &Toy) : u64 {
        arg0.issue
    }

    public fun max_supply(arg0: &Toy) : u64 {
        arg0.max_supply
    }

    public fun media_url(arg0: &Toy) : 0x2::url::Url {
        arg0.media_url
    }

    public fun name(arg0: &Toy) : 0x1::string::String {
        arg0.name
    }

    public fun points_price(arg0: &Toy) : u64 {
        arg0.points_price
    }

    public fun tier(arg0: &Toy) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"tier");
        *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)
    }

    public(friend) fun toggle_listing(arg0: &mut Toy) {
        arg0.is_listed = !arg0.is_listed;
    }

    public fun total_supply(arg0: &Toy) : u64 {
        arg0.total_supply
    }

    public(friend) fun update_points_price(arg0: &mut Toy, arg1: u64) {
        arg0.points_price = arg1;
    }

    public(friend) fun update_usd_price(arg0: &mut Toy, arg1: u64) {
        arg0.usd_price = arg1;
    }

    public fun usd_price(arg0: &Toy) : u64 {
        arg0.usd_price
    }

    public fun video_url(arg0: &Toy) : 0x2::url::Url {
        arg0.video_url
    }

    // decompiled from Move bytecode v7
}

