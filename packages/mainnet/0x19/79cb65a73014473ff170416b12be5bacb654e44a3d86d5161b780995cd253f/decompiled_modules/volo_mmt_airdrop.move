module 0x1979cb65a73014473ff170416b12be5bacb654e44a3d86d5161b780995cd253f::volo_mmt_airdrop {
    struct Volo_Momentum_xBTC has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    public fun transfer(arg0: Volo_Momentum_xBTC, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Volo_Momentum_xBTC>(arg0, arg1);
    }

    public fun url(arg0: &Volo_Momentum_xBTC) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: Volo_Momentum_xBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let Volo_Momentum_xBTC {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Volo_Momentum_xBTC) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MinterCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        mint(&v0, v1, arg0);
        0x2::transfer::public_transfer<MinterCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint(arg0: &MinterCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Volo_Momentum_xBTC{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"Volo x Momentum xBTC"),
            description : 0x1::string::utf8(b"Participant in Momentum x Volo Galxe campaign"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://red-general-pinniped-106.mypinata.cloud/ipfs/bafybeidyuxvbcyeo2vjxp52la42zb5rloadgxnqtnwtfff53rnt7wncelm"),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<Volo_Momentum_xBTC>(&v0),
            creator   : 0x2::tx_context::sender(arg2),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<Volo_Momentum_xBTC>(v0, arg1);
    }

    public fun name(arg0: &Volo_Momentum_xBTC) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

