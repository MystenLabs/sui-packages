module 0x47842962cb34b9aa7f5458afd1256f76fcaa45632912a5401aea53890786d79a::suiperb_sbt {
    struct SUIPERB_SBT has drop {
        dummy_field: bool,
    }

    struct IssuerCap has key {
        id: 0x2::object::UID,
        issuer: address,
    }

    struct SoulboundNFT has key {
        id: 0x2::object::UID,
        issuer: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        image_url: 0x1::string::String,
        animation_url: 0x1::string::String,
    }

    public fun animation_url_of(arg0: &SoulboundNFT) : 0x1::string::String {
        arg0.animation_url
    }

    public fun description_of(arg0: &SoulboundNFT) : 0x1::string::String {
        arg0.description
    }

    public fun id_of(arg0: &SoulboundNFT) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image_url_of(arg0: &SoulboundNFT) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: SUIPERB_SBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIPERB_SBT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"animation_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{animation_url}"));
        let v5 = 0x2::display::new_with_fields<SoulboundNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<SoulboundNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<SoulboundNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = IssuerCap{
            id     : 0x2::object::new(arg1),
            issuer : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<IssuerCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun is_issuer(arg0: &SoulboundNFT, arg1: address) : bool {
        arg0.issuer == arg1
    }

    public fun issuer_of(arg0: &SoulboundNFT) : address {
        arg0.issuer
    }

    public fun max_batch_size() : u64 {
        100
    }

    public fun metadata_of(arg0: &SoulboundNFT) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.name, arg0.description, arg0.url, arg0.image_url, arg0.animation_url)
    }

    public fun mint(arg0: &IssuerCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::package::Publisher, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = SoulboundNFT{
            id            : 0x2::object::new(arg8),
            issuer        : arg0.issuer,
            name          : arg2,
            description   : arg3,
            url           : arg4,
            image_url     : arg5,
            animation_url : arg6,
        };
        0x2::transfer::transfer<SoulboundNFT>(v0, arg1);
    }

    public fun mint_batch(arg0: &IssuerCap, arg1: vector<address>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::package::Publisher, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg2), 1);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg3), 2);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg4), 3);
        assert!(v0 > 0, 4);
        assert!(v0 <= 100, 5);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = SoulboundNFT{
                id            : 0x2::object::new(arg8),
                issuer        : arg0.issuer,
                name          : *0x1::vector::borrow<0x1::string::String>(&arg2, v1),
                description   : *0x1::vector::borrow<0x1::string::String>(&arg3, v1),
                url           : *0x1::vector::borrow<0x1::string::String>(&arg4, v1),
                image_url     : arg5,
                animation_url : arg6,
            };
            0x2::transfer::transfer<SoulboundNFT>(v2, *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
    }

    public fun mint_identical_batch(arg0: &IssuerCap, arg1: vector<address>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::package::Publisher, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 1);
        assert!(v0 <= 100, 2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = SoulboundNFT{
                id            : 0x2::object::new(arg8),
                issuer        : arg0.issuer,
                name          : arg2,
                description   : arg3,
                url           : arg4,
                image_url     : arg5,
                animation_url : arg6,
            };
            0x2::transfer::transfer<SoulboundNFT>(v2, *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
    }

    public fun name_of(arg0: &SoulboundNFT) : 0x1::string::String {
        arg0.name
    }

    public fun url_of(arg0: &SoulboundNFT) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

