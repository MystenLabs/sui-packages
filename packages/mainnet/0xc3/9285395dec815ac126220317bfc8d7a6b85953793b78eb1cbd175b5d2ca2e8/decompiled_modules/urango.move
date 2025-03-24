module 0xc39285395dec815ac126220317bfc8d7a6b85953793b78eb1cbd175b5d2ca2e8::urango {
    struct URANGO has drop {
        dummy_field: bool,
    }

    struct Socials has store, key {
        id: 0x2::object::UID,
        twitter: 0x1::string::String,
        website: 0x1::string::String,
        telegram: 0x1::string::String,
    }

    struct SocialsCreated has copy, drop {
        token_type: 0x1::string::String,
        socials_id: address,
    }

    fun init(arg0: URANGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URANGO>(arg0, 9, b"Urango", b"TAN", b"Unchain haven for xjs me.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihlwhhnezzp5crm2rhaksxtzxkfgc6gbkjz76seipklsvsyt3griq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<URANGO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = Socials{
            id       : 0x2::object::new(arg1),
            twitter  : 0x1::string::utf8(b"https://x.com/xhash"),
            website  : 0x1::string::utf8(b"https://urdbsjo.com"),
            telegram : 0x1::string::utf8(b"https://t.me/tg_gooo"),
        };
        let v4 = SocialsCreated{
            token_type : 0x1::string::utf8(b"orangu_token::urango::URANGO"),
            socials_id : 0x2::object::id_address<Socials>(&v3),
        };
        0x2::event::emit<SocialsCreated>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<URANGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URANGO>>(v2, @0x0);
        0x2::transfer::public_transfer<Socials>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

