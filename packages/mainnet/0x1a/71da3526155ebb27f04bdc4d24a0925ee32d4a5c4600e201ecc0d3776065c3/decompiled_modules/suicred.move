module 0x1a71da3526155ebb27f04bdc4d24a0925ee32d4a5c4600e201ecc0d3776065c3::suicred {
    struct SuiCredBadge has store, key {
        id: 0x2::object::UID,
        score: u64,
        tier: vector<u8>,
        name: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
    }

    public entry fun init_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new<SuiCredBadge>(arg0, arg1);
        0x2::display::add<SuiCredBadge>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuiCredBadge>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuiCredBadge>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<SuiCredBadge>(&mut v0, 0x1::string::utf8(b"score"), 0x1::string::utf8(b"{score}"));
        0x2::display::add<SuiCredBadge>(&mut v0, 0x1::string::utf8(b"tier"), 0x1::string::utf8(b"{tier}"));
        0x2::display::update_version<SuiCredBadge>(&mut v0);
        0x2::transfer::public_share_object<0x2::display::Display<SuiCredBadge>>(v0);
    }

    public entry fun mint_score(arg0: u64, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 10000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0xce5c72750ddcbfbead5c3690c580a7835eab6dacfef98f36cb167fc9f351e87f);
        let v0 = SuiCredBadge{
            id          : 0x2::object::new(arg3),
            score       : arg0,
            tier        : tier_for_score(arg0),
            name        : b"SuiCred Score Card",
            description : b"SuiCred on-chain reputation card.",
            image_url   : arg1,
        };
        0x2::transfer::transfer<SuiCredBadge>(v0, 0x2::tx_context::sender(arg3));
    }

    fun tier_for_score(arg0: u64) : vector<u8> {
        if (arg0 >= 500) {
            b"Sui"
        } else if (arg0 >= 350) {
            b"Diamond"
        } else if (arg0 >= 300) {
            b"Gold"
        } else if (arg0 >= 200) {
            b"Silver"
        } else {
            b"Bronze"
        }
    }

    // decompiled from Move bytecode v6
}

