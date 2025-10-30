module 0x3eaac1c030f0fb159f2ef910ef354ed1f9230d0d88ca4bb1ef3fe3e44377fa5::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: 0x1::string::String,
        supply: u8,
        symbol: 0x1::string::String,
        image_url: 0x1::string::String,
        website_url: 0x1::string::String,
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Tamashi"),
            description : 0x1::string::utf8(b"A collection of 100 uniquely created individuals looking to rebuild the soul of their long-lost world in their new capital city of Nozomi."),
            creator     : 0x1::string::utf8(b"@studiomirai"),
            supply      : 100,
            symbol      : 0x1::string::utf8(b"TAMASHI"),
            image_url   : 0x1::string::utf8(b"https://nozomi.world/images/collections/tamashi.webp"),
            website_url : 0x1::string::utf8(b"https://nozomi.world/collections/tamashi"),
        };
        0x2::transfer::freeze_object<Collection>(v0);
    }

    // decompiled from Move bytecode v6
}

