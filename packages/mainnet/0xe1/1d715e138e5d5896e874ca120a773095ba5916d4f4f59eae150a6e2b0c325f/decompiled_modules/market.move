module 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::market {
    struct PushBox has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        maps: vector<0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::map::Map>,
    }

    struct MapsMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun add_map(arg0: &mut PushBox, arg1: vector<vector<u8>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::map::Map>(&mut arg0.maps, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::map::create_map(arg1, arg2));
    }

    public entry fun burn(arg0: PushBox, arg1: &mut 0x2::tx_context::TxContext) {
        let PushBox {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            maps        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun buy(arg0: &PushBox, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PushBox{
            id          : 0x2::object::new(arg1),
            name        : arg0.name,
            description : arg0.description,
            url         : arg0.url,
            maps        : arg0.maps,
        };
        0x2::transfer::public_transfer<PushBox>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_maps(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = initialize_maps(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<PushBox>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun data(arg0: &PushBox) : &vector<0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::map::Map> {
        &arg0.maps
    }

    public fun data_mut(arg0: &mut PushBox) : &mut vector<0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::map::Map> {
        &mut arg0.maps
    }

    public fun description(arg0: &PushBox) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun initialize_maps(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : PushBox {
        let v0 = PushBox{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            maps        : 0x1::vector::empty<0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::map::Map>(),
        };
        let v1 = MapsMinted{
            object_id : 0x2::object::id<PushBox>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<MapsMinted>(v1);
        v0
    }

    public fun name(arg0: &PushBox) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut PushBox, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public entry fun update_map_data(arg0: &mut PushBox, arg1: u64, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::map::update_data(0x1::vector::borrow_mut<0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::map::Map>(data_mut(arg0), arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

