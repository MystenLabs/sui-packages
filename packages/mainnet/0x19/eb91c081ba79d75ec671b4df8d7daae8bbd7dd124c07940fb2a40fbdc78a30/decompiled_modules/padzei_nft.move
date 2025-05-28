module 0x19eb91c081ba79d75ec671b4df8d7daae8bbd7dd124c07940fb2a40fbdc78a30::padzei_nft {
    struct PadzeiNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        start: 0x1::string::String,
        place: 0x1::string::String,
        location: 0x1::string::String,
        location_url: 0x2::url::Url,
        people: 0x1::string::String,
        detailes_url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &PadzeiNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: PadzeiNFT) {
        let PadzeiNFT {
            id           : v0,
            name         : _,
            description  : _,
            url          : _,
            start        : _,
            place        : _,
            location     : _,
            location_url : _,
            people       : _,
            detailes_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &PadzeiNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = PadzeiNFT{
            id           : 0x2::object::new(arg9),
            name         : 0x1::string::utf8(arg0),
            description  : 0x1::string::utf8(arg1),
            url          : 0x2::url::new_unsafe_from_bytes(arg2),
            start        : 0x1::string::utf8(arg3),
            place        : 0x1::string::utf8(arg4),
            location     : 0x1::string::utf8(arg5),
            location_url : 0x2::url::new_unsafe_from_bytes(arg6),
            people       : 0x1::string::utf8(arg7),
            detailes_url : 0x2::url::new_unsafe_from_bytes(arg8),
        };
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<PadzeiNFT>(v0, v1);
    }

    public fun name(arg0: &PadzeiNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut PadzeiNFT, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public entry fun update_detailes_url(arg0: &mut PadzeiNFT, arg1: vector<u8>) {
        arg0.detailes_url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public entry fun update_location(arg0: &mut PadzeiNFT, arg1: vector<u8>) {
        arg0.location = 0x1::string::utf8(arg1);
    }

    public entry fun update_location_url(arg0: &mut PadzeiNFT, arg1: vector<u8>) {
        arg0.location_url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public entry fun update_name(arg0: &mut PadzeiNFT, arg1: vector<u8>) {
        arg0.name = 0x1::string::utf8(arg1);
    }

    public entry fun update_people(arg0: &mut PadzeiNFT, arg1: vector<u8>) {
        arg0.people = 0x1::string::utf8(arg1);
    }

    public entry fun update_place(arg0: &mut PadzeiNFT, arg1: vector<u8>) {
        arg0.place = 0x1::string::utf8(arg1);
    }

    public entry fun update_start(arg0: &mut PadzeiNFT, arg1: vector<u8>) {
        arg0.start = 0x1::string::utf8(arg1);
    }

    public entry fun update_url(arg0: &mut PadzeiNFT, arg1: vector<u8>) {
        arg0.url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    // decompiled from Move bytecode v6
}

