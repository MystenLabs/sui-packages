module 0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::gf256 {
    public(friend) fun add(arg0: u8, arg1: u8) : u8 {
        arg0 ^ arg1
    }

    public(friend) fun div(arg0: u8, arg1: u8) : u8 {
        mul(arg0, exp(255 - log(arg1)))
    }

    fun exp(arg0: u16) : u8 {
        let v0 = x"0103050f113355ff1a2e7296a1f813355fe13848d87395a4f702060a1e2266aae5345ce43759eb266abed97090abe63153f5040c143c44cc4fd168b8d36eb2cd4cd467a9e03b4dd762a6f10818287888839eb9d06bbddc7f8198b3ce49db769ab5c457f9103050f00b1d2769bbd661a3fe192b7d8792adec2f7193aee92060a0fb163a4ed26db7c25de73256fa153f41c35ee23d47c940c05bed2c749cbfda759fbad564acef2a7e829dbcdf7a8e89809bb6c158e82365afea256fb1c843c554fc1f2163a5f407091b2d7799b0cb46ca45cf4ade798b8691a8e33e42c651f30e12365aee297b8d8c8f8a8594a7f20d17394bdd7c8497a2fd1c246cb4c752f6";
        *0x1::vector::borrow<u8>(&v0, ((arg0 % 255) as u64))
    }

    fun log(arg0: u8) : u16 {
        assert!(arg0 != 0, 13906834393386713087);
        let v0 = x"00190132021ac64bc71b6833eedf036404e00e348d81ef4c7108c8f8691cc17dc21db5f9b9276a4de4a6729ac90978652f8a05210fe12412f082453593da8e968fdbbd36d0ce94135cd2f14046833866ddfd30bf068b62b325e298228891107e6e48c3a3b61e423a6b2854fa853dba2b790a159b9f5eca4ed4ace5f373a757af58a850f4ead6744faee9d5e7e6ade82cd7757aeb160bf559cb5fb09ca951a07f0cf66f17c449ecd8431f2da4767bb7ccbb3e5afb60b1863b52a16caa55299d97b2879061bedcfcbc95cfcd373f5bd15339843c41a26d47142a9e5d56f2d3ab441192d923202e89b47cb8267799e3a5674aeddec531fe180d638c80c0f77007";
        (*0x1::vector::borrow<u8>(&v0, ((arg0 - 1) as u64)) as u16)
    }

    public(friend) fun mul(arg0: u8, arg1: u8) : u8 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        exp(log(arg0) + log(arg1))
    }

    public(friend) fun sub(arg0: u8, arg1: u8) : u8 {
        add(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

