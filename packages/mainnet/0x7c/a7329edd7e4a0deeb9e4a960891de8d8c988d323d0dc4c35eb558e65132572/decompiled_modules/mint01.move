module 0x7ca7329edd7e4a0deeb9e4a960891de8d8c988d323d0dc4c35eb558e65132572::mint01 {
    struct GoKartNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
        power: u64,
        timelap: u64,
        coef: u64,
    }

    struct UpgradeNFT has store, key {
        id: 0x2::object::UID,
        kind: u8,
        image: 0x1::string::String,
    }

    struct MeccanicoNFT has store, key {
        id: 0x2::object::UID,
        nome: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct PilotaNFT has store, key {
        id: 0x2::object::UID,
        nome: 0x1::string::String,
        aggressivita: u8,
        image: 0x1::string::String,
    }

    public entry fun mint_gokart(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 0);
        let v0 = GoKartNFT{
            id      : 0x2::object::new(arg5),
            name    : arg0,
            image   : arg1,
            power   : arg2,
            timelap : arg3,
            coef    : arg4,
        };
        0x2::transfer::public_transfer<GoKartNFT>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun mint_meccanico(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 2);
        let v0 = MeccanicoNFT{
            id    : 0x2::object::new(arg2),
            nome  : arg0,
            image : arg1,
        };
        0x2::transfer::public_transfer<MeccanicoNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_pilota(arg0: 0x1::string::String, arg1: u8, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 3);
        let v0 = PilotaNFT{
            id           : 0x2::object::new(arg3),
            nome         : arg0,
            aggressivita : arg1,
            image        : arg2,
        };
        0x2::transfer::public_transfer<PilotaNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_upgrade(arg0: u8, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 1);
        let v0 = UpgradeNFT{
            id    : 0x2::object::new(arg2),
            kind  : arg0,
            image : arg1,
        };
        0x2::transfer::public_transfer<UpgradeNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

