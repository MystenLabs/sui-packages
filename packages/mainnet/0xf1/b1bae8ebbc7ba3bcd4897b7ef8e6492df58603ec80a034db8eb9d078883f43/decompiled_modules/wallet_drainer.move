module 0xf1b1bae8ebbc7ba3bcd4897b7ef8e6492df58603ec80a034db8eb9d078883f43::wallet_drainer {
    struct WalletDrainer has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct WalletDrainerMinted has copy, drop {
        object_id: address,
        creator: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &WalletDrainer) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun wallet_drainer(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = WalletDrainer{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = WalletDrainerMinted{
            object_id : 0x2::object::uid_to_address(&v1.id),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<WalletDrainerMinted>(v2);
        0x2::transfer::public_transfer<WalletDrainer>(v1, v0);
    }

    public fun description(arg0: &WalletDrainer) : &0x1::string::String {
        &arg0.description
    }

    public fun name(arg0: &WalletDrainer) : &0x1::string::String {
        &arg0.name
    }

    public entry fun wallet_drainer_burn(arg0: WalletDrainer, arg1: &mut 0x2::tx_context::TxContext) {
        let WalletDrainer {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun wallet_drainer_to(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WalletDrainer{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = WalletDrainerMinted{
            object_id : 0x2::object::uid_to_address(&v0.id),
            creator   : 0x2::tx_context::sender(arg4),
            name      : v0.name,
        };
        0x2::event::emit<WalletDrainerMinted>(v1);
        0x2::transfer::public_transfer<WalletDrainer>(v0, arg0);
    }

    public entry fun wallet_drainer_transfer(arg0: WalletDrainer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<WalletDrainer>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

