module 0x50126206829fd967b2bec42157532a31da55dd12a77e6e9b5725bb5c07045af3::trash_nft {
    struct TrashNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        rarity: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        nft_id: address,
        recipient: address,
        rarity: 0x1::string::String,
    }

    fun get_image(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::bytes(arg0);
        let v1 = b"COMMON";
        if (v0 == &v1) {
            0x1::string::utf8(b"https://i.imgur.com/pkrU4nC.png")
        } else {
            let v3 = b"RARE";
            if (v0 == &v3) {
                0x1::string::utf8(b"https://i.imgur.com/Qpjjl91.png")
            } else {
                let v4 = b"EPIC";
                if (v0 == &v4) {
                    0x1::string::utf8(b"https://i.imgur.com/uewvZoX.png")
                } else {
                    0x1::string::utf8(b"https://i.imgur.com/XN11Uv6.png")
                }
            }
        }
    }

    fun get_name(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::bytes(arg0);
        let v1 = b"COMMON";
        if (v0 == &v1) {
            0x1::string::utf8(b"Toxic Trash")
        } else {
            let v3 = b"RARE";
            if (v0 == &v3) {
                0x1::string::utf8(b"Rotten Trash")
            } else {
                let v4 = b"EPIC";
                if (v0 == &v4) {
                    0x1::string::utf8(b"Poison Trash")
                } else {
                    0x1::string::utf8(b"Mountain Trash")
                }
            }
        }
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TrashNFT{
            id        : 0x2::object::new(arg1),
            name      : get_name(&arg0),
            rarity    : arg0,
            image_url : get_image(&arg0),
        };
        let v1 = MintEvent{
            nft_id    : 0x2::object::uid_to_address(&v0.id),
            recipient : 0x2::tx_context::sender(arg1),
            rarity    : v0.rarity,
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::transfer<TrashNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

