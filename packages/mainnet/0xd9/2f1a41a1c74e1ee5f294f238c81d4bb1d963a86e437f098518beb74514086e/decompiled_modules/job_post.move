module 0xd92f1a41a1c74e1ee5f294f238c81d4bb1d963a86e437f098518beb74514086e::job_post {
    struct JobPostNFT has key {
        id: 0x2::object::UID,
        company: 0x1::string::String,
        email: 0x1::string::String,
        discord: 0x2::url::Url,
        twitter: 0x2::url::Url,
        name: 0x1::string::String,
        description: 0x1::string::String,
        reward: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct JOB_POST has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: JobPostNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<JobPostNFT>(arg0, arg1);
    }

    public entry fun burn(arg0: JobPostNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let JobPostNFT {
            id          : v0,
            company     : _,
            email       : _,
            discord     : _,
            twitter     : _,
            name        : _,
            description : _,
            reward      : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun company(arg0: &JobPostNFT) : &0x1::string::String {
        &arg0.company
    }

    public fun description(arg0: &JobPostNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun discord(arg0: &JobPostNFT) : &0x2::url::Url {
        &arg0.discord
    }

    public fun email(arg0: &JobPostNFT) : &0x1::string::String {
        &arg0.email
    }

    public fun image_url(arg0: &JobPostNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: JOB_POST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"company"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"email"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"discord"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"twitter"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"reward"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{company}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{email}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{discord}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{twitter}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{reward}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<JOB_POST>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<JobPostNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<JobPostNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<JobPostNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = JobPostNFT{
            id          : 0x2::object::new(arg8),
            company     : 0x1::string::utf8(arg0),
            email       : 0x1::string::utf8(arg1),
            discord     : 0x2::url::new_unsafe_from_bytes(arg2),
            twitter     : 0x2::url::new_unsafe_from_bytes(arg3),
            name        : 0x1::string::utf8(arg4),
            description : 0x1::string::utf8(arg5),
            reward      : 0x1::string::utf8(arg6),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg7),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<JobPostNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg8),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::transfer<JobPostNFT>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun name(arg0: &JobPostNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun reward(arg0: &JobPostNFT) : &0x1::string::String {
        &arg0.reward
    }

    public fun twitter(arg0: &JobPostNFT) : &0x2::url::Url {
        &arg0.twitter
    }

    public entry fun update_nft(arg0: &mut JobPostNFT, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        arg0.email = 0x1::string::utf8(arg1);
        arg0.discord = 0x2::url::new_unsafe_from_bytes(arg2);
        arg0.twitter = 0x2::url::new_unsafe_from_bytes(arg3);
        arg0.name = 0x1::string::utf8(arg4);
        arg0.description = 0x1::string::utf8(arg5);
        arg0.reward = 0x1::string::utf8(arg6);
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(arg7);
    }

    // decompiled from Move bytecode v6
}

