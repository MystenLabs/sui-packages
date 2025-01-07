module 0x50d0b895334054ec8bfd7db342f7a1f007715d8740037169a13a52ef237fb733::miner {
    struct MINER has drop {
        dummy_field: bool,
    }

    struct Miner has key {
        id: 0x2::object::UID,
        type: u8,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        id: 0x2::object::ID,
        type: u8,
        amount: u64,
        sender: address,
    }

    fun init(arg0: MINER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"KPRM"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        let v5 = 0x2::package::claim<MINER>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<Miner>(&v5, v1, v3, arg1);
        0x2::display::update_version<Miner>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Miner>>(v6, v0);
    }

    public entry fun mint(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(1 <= arg1 && arg1 <= 4, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::string::utf8(b"");
        let v2 = 0x1::string::utf8(b"");
        if (arg1 == 1) {
            v1 = 0x1::string::utf8(b"https://capkqmk7jqogksnnlz6ydxepmbfji27dpnsfa6mu56g2av6q7jwq.arweave.net/EB6oMV9MHGVJrV59gdyPYEqUa-N7ZFB5lO-NoFfQ-m0");
            v2 = 0x1::string::utf8(b"48h sKART Mining Machine");
        };
        if (arg1 == 2) {
            v1 = 0x1::string::utf8(b"https://phqrphrj6cwler5itpv3xfbn2fyljevpp2jjfw6gd5lbptkifima.arweave.net/eeEXninwrLJHqJvru5Qt0XC0kq9-kpLbxh9WF81IKhg");
            v2 = 0x1::string::utf8(b"7 days sKART Mining Machine");
        };
        if (arg1 == 3) {
            v1 = 0x1::string::utf8(b"https://j7u6ibzulbtwpirco3fjs25frpnulu2jigieybppsrpvjq422tea.arweave.net/T-nkBzRYZ2eiInbKmWuli9tF00lBkEwF75RfVMOa1Mg");
            v2 = 0x1::string::utf8(b"30 days sKART Mining Machine");
        };
        if (arg1 == 4) {
            v1 = 0x1::string::utf8(b"https://tc3op34m2cygotar4xsey33ognpr2tiwlgwvaagcswlfhchjbdea.arweave.net/mLbn74zQsGdMEeXkTG9uM18dTRZZrVAAwpWWU4jpCMg");
            v2 = 0x1::string::utf8(b"60 days sKART Mining Machine");
        };
        let v3 = Miner{
            id          : 0x2::object::new(arg2),
            type        : arg1,
            image_url   : v1,
            description : v2,
        };
        let v4 = MintEvent{
            id     : 0x2::object::id<Miner>(&v3),
            type   : arg1,
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            sender : v0,
        };
        0x2::event::emit<MintEvent>(v4);
        0x2::transfer::transfer<Miner>(v3, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0xbef1197d33afe94e6b2eb81be379a3acf6804e45def0f2e92e53a3a29d1cebae);
    }

    // decompiled from Move bytecode v6
}

