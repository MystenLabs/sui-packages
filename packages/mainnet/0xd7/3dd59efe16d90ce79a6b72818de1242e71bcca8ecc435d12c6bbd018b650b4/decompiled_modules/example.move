module 0xd73dd59efe16d90ce79a6b72818de1242e71bcca8ecc435d12c6bbd018b650b4::example {
    struct EthosExample has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        message: 0x1::string::String,
        url: 0x1::string::String,
    }

    fun new(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : EthosExample {
        EthosExample{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Ethos Example"),
            description : 0x1::string::utf8(b"An example Sui object build by Ethos"),
            message     : arg0,
            url         : url(arg0),
        }
    }

    public entry fun transfer(arg0: EthosExample, arg1: address) {
        0x2::transfer::transfer<EthosExample>(arg0, arg1);
    }

    public entry fun burn(arg0: EthosExample) {
        let EthosExample {
            id          : v0,
            name        : _,
            description : _,
            message     : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun clone(arg0: &EthosExample, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0.message, arg1);
        0x2::transfer::transfer<EthosExample>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(0x1::string::utf8(b"Hey there!"), arg0);
        0x2::transfer::transfer<EthosExample>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun modify(arg0: &mut EthosExample, arg1: vector<u8>) {
        arg0.message = 0x1::string::utf8(arg1);
        arg0.url = url(arg0.message);
    }

    fun url(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"data:image/svg+xml;utf8,%3Csvg width='150' height='150' viewBox='0 0 150 150' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cg%3E%3Cpath d='M75 0L91.7327 12.5529L112.5 10.0481L120.714 29.2855L139.952 37.5L137.447 58.2673L150 75L137.447 91.7327L139.952 112.5L120.714 120.714L112.5 139.952L91.7327 137.447L75 150L58.2673 137.447L37.5 139.952L29.2855 120.714L10.0481 112.5L12.5529 91.7327L0 75L12.5529 58.2673L10.0481 37.5L29.2855 29.2855L37.5 10.0481L58.2673 12.5529L75 0Z' fill='%231100D2'/%3E%3Ctext x='50%25' y='50%25' dominant-baseline='center' text-anchor='middle' fill='white'%3E ");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b" %3C/text%3E%3C/g%3E%3C/svg%3E%0A"));
        v0
    }

    // decompiled from Move bytecode v6
}

