module 0xa49c80f472b4b66991d0297db44040a0ba55372d3af31557be92e80ff6c78172::non_transferable_nft {
    struct NonTransferableNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct NonTransferableNFTTransferPolicy has store, key {
        id: 0x2::object::UID,
    }

    public fun description(arg0: &NonTransferableNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NonTransferableNFTTransferPolicy{id: 0x2::object::new(arg0)};
        0x2::transfer::freeze_object<NonTransferableNFTTransferPolicy>(v0);
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = NonTransferableNFT{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            url         : arg2,
        };
        0x2::transfer::transfer<NonTransferableNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &NonTransferableNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun send(arg0: NonTransferableNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<NonTransferableNFT>(arg0, arg1);
    }

    public fun url(arg0: &NonTransferableNFT) : &0x1::string::String {
        &arg0.url
    }

    // decompiled from Move bytecode v6
}

