module 0x8553916e6deefabfb4ec9b61baaa240f189385b301742b72c93fa8723f317630::dragon_card {
    struct DRAGON_CARD has drop {
        dummy_field: bool,
    }

    struct DragonCard has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        image_blob_id: 0x1::string::String,
        edition: u64,
        tier: 0x1::string::String,
        project: 0x1::string::String,
    }

    struct CardMinted has copy, drop {
        card_id: address,
        minter: address,
        edition: u64,
        blob_id: 0x1::string::String,
    }

    public fun blob_id(arg0: &DragonCard) : &0x1::string::String {
        &arg0.image_blob_id
    }

    public fun edition(arg0: &DragonCard) : u64 {
        arg0.edition
    }

    public fun image_url(arg0: &DragonCard) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: DRAGON_CARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DRAGON_CARD>(arg0, arg1);
        let v1 = 0x2::display::new<DragonCard>(&v0, arg1);
        0x2::display::add<DragonCard>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<DragonCard>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<DragonCard>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<DragonCard>(&mut v1, 0x1::string::utf8(b"edition"), 0x1::string::utf8(b"{edition}"));
        0x2::display::add<DragonCard>(&mut v1, 0x1::string::utf8(b"tier"), 0x1::string::utf8(b"{tier}"));
        0x2::display::add<DragonCard>(&mut v1, 0x1::string::utf8(b"project"), 0x1::string::utf8(b"{project}"));
        0x2::display::update_version<DragonCard>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DragonCard>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg0));
        let v1 = DragonCard{
            id            : 0x2::object::new(arg2),
            name          : 0x1::string::utf8(b"Dragonplay Commander"),
            description   : 0x1::string::utf8(b"Dragonplay Commander | Sui Frontier Hackathon 2026 | Genesis 001/500 | Apex Tier"),
            image_url     : v0,
            image_blob_id : 0x1::string::utf8(arg0),
            edition       : arg1,
            tier          : 0x1::string::utf8(b"APEX"),
            project       : 0x1::string::utf8(b"Dragonplay"),
        };
        let v2 = CardMinted{
            card_id : 0x2::object::uid_to_address(&v1.id),
            minter  : 0x2::tx_context::sender(arg2),
            edition : arg1,
            blob_id : 0x1::string::utf8(arg0),
        };
        0x2::event::emit<CardMinted>(v2);
        0x2::transfer::transfer<DragonCard>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun name(arg0: &DragonCard) : &0x1::string::String {
        &arg0.name
    }

    public fun tier(arg0: &DragonCard) : &0x1::string::String {
        &arg0.tier
    }

    // decompiled from Move bytecode v6
}

