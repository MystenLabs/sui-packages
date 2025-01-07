module 0xe24d1dd5860dd4466d1f8f2da1fa8f3c3b37b007ff7be7865a6f8a6a1242c830::zzf222nft {
    struct Zzfnft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public entry fun transfer(arg0: Zzfnft, arg1: address) {
        0x2::transfer::transfer<Zzfnft>(arg0, arg1);
    }

    public fun url(arg0: &Zzfnft) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: Zzfnft) {
        let Zzfnft {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Zzfnft) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Zzfnft{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::transfer<Zzfnft>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &Zzfnft) : &0x1::string::String {
        &arg0.name
    }

    public entry fun rename(arg0: &mut Zzfnft, arg1: vector<u8>, arg2: vector<u8>) {
        arg0.name = 0x1::string::utf8(arg1);
        arg0.description = 0x1::string::utf8(arg2);
    }

    // decompiled from Move bytecode v6
}

