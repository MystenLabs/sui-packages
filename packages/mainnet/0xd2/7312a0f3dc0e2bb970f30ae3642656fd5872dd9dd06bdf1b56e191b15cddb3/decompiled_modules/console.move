module 0x9807b3bb5358171cb9d3ca47b7061ade45d13637a4e9eb2bb4e59ed631b5551b::console {
    struct CONSOLE has drop {
        dummy_field: bool,
    }

    struct Console has store, key {
        id: 0x2::object::UID,
        number: u64,
        skin_id: u8,
        skin_name: 0x1::string::String,
        image_uri: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        price: u64,
        treasury: address,
        minted: u64,
        paused: bool,
    }

    struct StickerSlotKey has copy, drop, store {
        slot: u8,
    }

    struct ConsoleMinted has copy, drop {
        console_id: address,
        number: u64,
        skin_id: u8,
        minter: address,
    }

    struct StickerAttached has copy, drop {
        console_id: address,
        slot: u8,
        sticker_id: address,
    }

    struct StickerDetached has copy, drop {
        console_id: address,
        slot: u8,
        sticker_id: address,
    }

    struct ConsoleBurned has copy, drop {
        console_id: address,
        number: u64,
    }

    entry fun attach_sticker(arg0: &mut Console, arg1: 0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::Sticker, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 4, 3);
        let v0 = StickerSlotKey{slot: arg2};
        assert!(!0x2::dynamic_object_field::exists_<StickerSlotKey>(&arg0.id, v0), 4);
        0x2::dynamic_object_field::add<StickerSlotKey, 0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::Sticker>(&mut arg0.id, v0, arg1);
        arg0.image_uri = compose_image(arg0.skin_id, &arg0.id);
        let v1 = StickerAttached{
            console_id : 0x2::object::uid_to_address(&arg0.id),
            slot       : arg2,
            sticker_id : 0x2::object::id_address<0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::Sticker>(&arg1),
        };
        0x2::event::emit<StickerAttached>(v1);
    }

    fun base64_encode(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        let v1 = 0x1::vector::length<u8>(&arg0);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 + 3 <= v1) {
            let v4 = *0x1::vector::borrow<u8>(&arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(&arg0, v3 + 1);
            let v6 = *0x1::vector::borrow<u8>(&arg0, v3 + 2);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v4 >> 2) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, (((v4 & 3) << 4 | v5 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, (((v5 & 15) << 2 | v6 >> 6) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v6 & 63) as u64)));
            v3 = v3 + 3;
        };
        let v7 = v1 - v3;
        if (v7 == 1) {
            let v8 = *0x1::vector::borrow<u8>(&arg0, v3);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v8 >> 2) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, (((v8 & 3) << 4) as u64)));
            0x1::vector::push_back<u8>(&mut v2, 61);
            0x1::vector::push_back<u8>(&mut v2, 61);
        } else if (v7 == 2) {
            let v9 = *0x1::vector::borrow<u8>(&arg0, v3);
            let v10 = *0x1::vector::borrow<u8>(&arg0, v3 + 1);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v9 >> 2) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, (((v9 & 3) << 4 | v10 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, (((v10 & 15) << 2) as u64)));
            0x1::vector::push_back<u8>(&mut v2, 61);
        };
        0x1::string::utf8(v2)
    }

    entry fun burn_console(arg0: Console, arg1: &mut 0x2::tx_context::TxContext) {
        let Console {
            id        : v0,
            number    : v1,
            skin_id   : _,
            skin_name : _,
            image_uri : _,
        } = arg0;
        let v5 = v0;
        let v6 = 0;
        while (v6 < 4) {
            let v7 = StickerSlotKey{slot: v6};
            if (0x2::dynamic_object_field::exists_<StickerSlotKey>(&v5, v7)) {
                0x2::transfer::public_transfer<0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::Sticker>(0x2::dynamic_object_field::remove<StickerSlotKey, 0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::Sticker>(&mut v5, v7), 0x2::tx_context::sender(arg1));
            };
            v6 = v6 + 1;
        };
        let v8 = ConsoleBurned{
            console_id : 0x2::object::uid_to_address(&v5),
            number     : v1,
        };
        0x2::event::emit<ConsoleBurned>(v8);
        0x2::object::delete(v5);
    }

    fun compose_image(arg0: u8, arg1: &0x2::object::UID) : 0x1::string::String {
        let v0 = skin_head(arg0);
        let v1 = 0;
        while (v1 < 4) {
            let v2 = StickerSlotKey{slot: v1};
            if (0x2::dynamic_object_field::exists_<StickerSlotKey>(arg1, v2)) {
                0x1::string::append(&mut v0, slot_group_open(v1));
                0x1::string::append(&mut v0, 0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::fragment(0x2::dynamic_object_field::borrow<StickerSlotKey, 0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::Sticker>(arg1, v2)));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"</g>"));
            };
            v1 = v1 + 1;
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</g></svg>"));
        let v3 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        0x1::string::append(&mut v3, base64_encode(0x1::string::into_bytes(v0)));
        v3
    }

    entry fun detach_sticker(arg0: &mut Console, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = take_sticker(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::Sticker>(v0, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: CONSOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CONSOLE>(arg0, arg1);
        let v1 = 0x2::display::new<Console>(&v0, arg1);
        0x2::display::add<Console>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"SuiBoy Console #{number}"));
        0x2::display::add<Console>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A fully on-chain SuiBoy handheld. Skin: {skin_name}. Owning this unlocks the Play tab at suiboy.fun."));
        0x2::display::add<Console>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_uri}"));
        0x2::display::add<Console>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suiboy.fun"));
        0x2::display::update_version<Console>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Console>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = MintConfig{
            id       : 0x2::object::new(arg1),
            price    : 1000000000,
            treasury : @0xe1089d77e25643ea64ea003106ee093f9d066ad1579027ac8f5f2e0779e190a8,
            minted   : 0,
            paused   : false,
        };
        0x2::transfer::share_object<MintConfig>(v3);
    }

    entry fun mint(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg0.minted < 3333, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.price, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
        arg0.minted = arg0.minted + 1;
        let v0 = arg0.minted;
        let v1 = 0x2::random::new_generator(arg2, arg3);
        let v2 = 0x2::random::generate_u8_in_range(&mut v1, 0, 5 - 1);
        let v3 = 0x2::object::new(arg3);
        let v4 = Console{
            id        : v3,
            number    : v0,
            skin_id   : v2,
            skin_name : skin_name(v2),
            image_uri : compose_image(v2, &v3),
        };
        let v5 = ConsoleMinted{
            console_id : 0x2::object::uid_to_address(&v4.id),
            number     : v0,
            skin_id    : v2,
            minter     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ConsoleMinted>(v5);
        0x2::transfer::public_transfer<Console>(v4, 0x2::tx_context::sender(arg3));
    }

    entry fun set_paused(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    entry fun set_price(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.price = arg2;
    }

    entry fun set_treasury(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    entry fun setup_royalty_policy(arg0: &AdminCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<Console>(arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::royalty_rule::add<Console>(&mut v3, &v2, 200, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Console>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Console>>(v2, 0x2::tx_context::sender(arg2));
    }

    fun skin_head(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"<svg viewBox='0 0 480 480' xmlns='http://www.w3.org/2000/svg' role='img'><title>SuiBoy Console - CLASSIC GREEN</title><rect width='480' height='480' fill='#101016'/><g transform='translate(121.25,27.50) scale(1.25)'><linearGradient id='shellG' x1='0' y1='0' x2='0' y2='1'><stop offset='0' stop-color='#c9cabb'/><stop offset='1' stop-color='#adad9d'/></linearGradient><linearGradient id='bezelG' x1='0' y1='0' x2='0' y2='1'><stop offset='0' stop-color='#2a2a38'/><stop offset='1' stop-color='#17171f'/></linearGradient><path d='M16,0 L174,0 Q190,0 190,16 L190,308 Q190,340 158,340 L32,340 Q0,340 0,308 L0,16 Q0,0 16,0 Z' fill='url(#shellG)'/><circle cx='15' cy='15' r='3.2' fill='#ff3b3b'/><circle cx='26' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='31' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='36' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='26' cy='18.5' r='1.3' fill='#6b6b78'/><circle cx='31' cy='18.5' r='1.3' fill='#6b6b78'/><circle cx='36' cy='18.5' r='1.3' fill='#6b6b78'/><text x='174' y='18' font-size='9' font-weight='700' text-anchor='end' fill='#4b3a63' font-family='Georgia, serif' font-style='italic'>SuiBoy</text><rect x='11' y='28' width='168' height='168' rx='12' fill='url(#bezelG)'/><rect x='20' y='37' width='150' height='150' rx='6' fill='#9bbc0f'/><g opacity='0.12' stroke='#2f2340' stroke-width='1'><line x1='20' y1='67' x2='170' y2='67'/><line x1='20' y1='97' x2='170' y2='97'/><line x1='20' y1='127' x2='170' y2='127'/><line x1='20' y1='157' x2='170' y2='157'/></g><g transform='translate(26,214)'><rect x='13' y='0' width='13' height='13' fill='#3c3250'/><rect x='0' y='13' width='13' height='13' fill='#3c3250'/><rect x='13' y='13' width='13' height='13' fill='#2c2438'/><rect x='26' y='13' width='13' height='13' fill='#3c3250'/><rect x='13' y='26' width='13' height='13' fill='#3c3250'/></g><circle cx='145' cy='233' r='17' fill='#52436b'/>")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"<svg viewBox='0 0 480 480' xmlns='http://www.w3.org/2000/svg' role='img'><title>SuiBoy Console - SUI BLUE</title><rect width='480' height='480' fill='#101016'/><g transform='translate(121.25,27.50) scale(1.25)'><linearGradient id='shellG' x1='0' y1='0' x2='0' y2='1'><stop offset='0' stop-color='#bcd8ee'/><stop offset='1' stop-color='#8fb9d9'/></linearGradient><linearGradient id='bezelG' x1='0' y1='0' x2='0' y2='1'><stop offset='0' stop-color='#0b2036'/><stop offset='1' stop-color='#04101c'/></linearGradient><path d='M16,0 L174,0 Q190,0 190,16 L190,308 Q190,340 158,340 L32,340 Q0,340 0,308 L0,16 Q0,0 16,0 Z' fill='url(#shellG)'/><circle cx='15' cy='15' r='3.2' fill='#ff3b3b'/><circle cx='26' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='31' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='36' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='26' cy='18.5' r='1.3' fill='#6b6b78'/><circle cx='31' cy='18.5' r='1.3' fill='#6b6b78'/><circle cx='36' cy='18.5' r='1.3' fill='#6b6b78'/><text x='174' y='18' font-size='9' font-weight='700' text-anchor='end' fill='#0f4c85' font-family='Georgia, serif' font-style='italic'>SuiBoy</text><rect x='11' y='28' width='168' height='168' rx='12' fill='url(#bezelG)'/><rect x='20' y='37' width='150' height='150' rx='6' fill='#bfe9ff'/><g opacity='0.12' stroke='#062544' stroke-width='1'><line x1='20' y1='67' x2='170' y2='67'/><line x1='20' y1='97' x2='170' y2='97'/><line x1='20' y1='127' x2='170' y2='127'/><line x1='20' y1='157' x2='170' y2='157'/></g><g transform='translate(26,214)'><rect x='13' y='0' width='13' height='13' fill='#155187'/><rect x='0' y='13' width='13' height='13' fill='#155187'/><rect x='13' y='13' width='13' height='13' fill='#0b3760'/><rect x='26' y='13' width='13' height='13' fill='#155187'/><rect x='13' y='26' width='13' height='13' fill='#155187'/></g><circle cx='145' cy='233' r='17' fill='#1f6bb0'/>")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"<svg viewBox='0 0 480 480' xmlns='http://www.w3.org/2000/svg' role='img'><title>SuiBoy Console - RUBY RED</title><rect width='480' height='480' fill='#101016'/><g transform='translate(121.25,27.50) scale(1.25)'><linearGradient id='shellG' x1='0' y1='0' x2='0' y2='1'><stop offset='0' stop-color='#e3b7bd'/><stop offset='1' stop-color='#cf8f97'/></linearGradient><linearGradient id='bezelG' x1='0' y1='0' x2='0' y2='1'><stop offset='0' stop-color='#2c1013'/><stop offset='1' stop-color='#180a0b'/></linearGradient><path d='M16,0 L174,0 Q190,0 190,16 L190,308 Q190,340 158,340 L32,340 Q0,340 0,308 L0,16 Q0,0 16,0 Z' fill='url(#shellG)'/><circle cx='15' cy='15' r='3.2' fill='#ff3b3b'/><circle cx='26' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='31' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='36' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='26' cy='18.5' r='1.3' fill='#6b6b78'/><circle cx='31' cy='18.5' r='1.3' fill='#6b6b78'/><circle cx='36' cy='18.5' r='1.3' fill='#6b6b78'/><text x='174' y='18' font-size='9' font-weight='700' text-anchor='end' fill='#7a1f2b' font-family='Georgia, serif' font-style='italic'>SuiBoy</text><rect x='11' y='28' width='168' height='168' rx='12' fill='url(#bezelG)'/><rect x='20' y='37' width='150' height='150' rx='6' fill='#ffd3d3'/><g opacity='0.12' stroke='#4a0f18' stroke-width='1'><line x1='20' y1='67' x2='170' y2='67'/><line x1='20' y1='97' x2='170' y2='97'/><line x1='20' y1='127' x2='170' y2='127'/><line x1='20' y1='157' x2='170' y2='157'/></g><g transform='translate(26,214)'><rect x='13' y='0' width='13' height='13' fill='#6e1822'/><rect x='0' y='13' width='13' height='13' fill='#6e1822'/><rect x='13' y='13' width='13' height='13' fill='#511119'/><rect x='26' y='13' width='13' height='13' fill='#6e1822'/><rect x='13' y='26' width='13' height='13' fill='#6e1822'/></g><circle cx='145' cy='233' r='17' fill='#8f2733'/>")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"<svg viewBox='0 0 480 480' xmlns='http://www.w3.org/2000/svg' role='img'><title>SuiBoy Console - GRAPE PURPLE</title><rect width='480' height='480' fill='#101016'/><g transform='translate(121.25,27.50) scale(1.25)'><linearGradient id='shellG' x1='0' y1='0' x2='0' y2='1'><stop offset='0' stop-color='#c9b8e0'/><stop offset='1' stop-color='#a88fcb'/></linearGradient><linearGradient id='bezelG' x1='0' y1='0' x2='0' y2='1'><stop offset='0' stop-color='#1e1230'/><stop offset='1' stop-color='#0f091a'/></linearGradient><path d='M16,0 L174,0 Q190,0 190,16 L190,308 Q190,340 158,340 L32,340 Q0,340 0,308 L0,16 Q0,0 16,0 Z' fill='url(#shellG)'/><circle cx='15' cy='15' r='3.2' fill='#ff3b3b'/><circle cx='26' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='31' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='36' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='26' cy='18.5' r='1.3' fill='#6b6b78'/><circle cx='31' cy='18.5' r='1.3' fill='#6b6b78'/><circle cx='36' cy='18.5' r='1.3' fill='#6b6b78'/><text x='174' y='18' font-size='9' font-weight='700' text-anchor='end' fill='#4b1f7a' font-family='Georgia, serif' font-style='italic'>SuiBoy</text><rect x='11' y='28' width='168' height='168' rx='12' fill='url(#bezelG)'/><rect x='20' y='37' width='150' height='150' rx='6' fill='#dcc6ff'/><g opacity='0.12' stroke='#2c0f4a' stroke-width='1'><line x1='20' y1='67' x2='170' y2='67'/><line x1='20' y1='97' x2='170' y2='97'/><line x1='20' y1='127' x2='170' y2='127'/><line x1='20' y1='157' x2='170' y2='157'/></g><g transform='translate(26,214)'><rect x='13' y='0' width='13' height='13' fill='#42206b'/><rect x='0' y='13' width='13' height='13' fill='#42206b'/><rect x='13' y='13' width='13' height='13' fill='#2f1450'/><rect x='26' y='13' width='13' height='13' fill='#42206b'/><rect x='13' y='26' width='13' height='13' fill='#42206b'/></g><circle cx='145' cy='233' r='17' fill='#54277f'/>")
        } else {
            0x1::string::utf8(b"<svg viewBox='0 0 480 480' xmlns='http://www.w3.org/2000/svg' role='img'><title>SuiBoy Console - CARBON BLACK</title><rect width='480' height='480' fill='#101016'/><g transform='translate(121.25,27.50) scale(1.25)'><linearGradient id='shellG' x1='0' y1='0' x2='0' y2='1'><stop offset='0' stop-color='#3a3a3d'/><stop offset='1' stop-color='#232325'/></linearGradient><linearGradient id='bezelG' x1='0' y1='0' x2='0' y2='1'><stop offset='0' stop-color='#0d0d0e'/><stop offset='1' stop-color='#000000'/></linearGradient><path d='M16,0 L174,0 Q190,0 190,16 L190,308 Q190,340 158,340 L32,340 Q0,340 0,308 L0,16 Q0,0 16,0 Z' fill='url(#shellG)'/><circle cx='15' cy='15' r='3.2' fill='#ff3b3b'/><circle cx='26' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='31' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='36' cy='11.5' r='1.3' fill='#6b6b78'/><circle cx='26' cy='18.5' r='1.3' fill='#6b6b78'/><circle cx='31' cy='18.5' r='1.3' fill='#6b6b78'/><circle cx='36' cy='18.5' r='1.3' fill='#6b6b78'/><text x='174' y='18' font-size='9' font-weight='700' text-anchor='end' fill='#ffb000' font-family='Georgia, serif' font-style='italic'>SuiBoy</text><rect x='11' y='28' width='168' height='168' rx='12' fill='url(#bezelG)'/><rect x='20' y='37' width='150' height='150' rx='6' fill='#2b1a05'/><g opacity='0.12' stroke='#eef0f5' stroke-width='1'><line x1='20' y1='67' x2='170' y2='67'/><line x1='20' y1='97' x2='170' y2='97'/><line x1='20' y1='127' x2='170' y2='127'/><line x1='20' y1='157' x2='170' y2='157'/></g><g transform='translate(26,214)'><rect x='13' y='0' width='13' height='13' fill='#2a2a2c'/><rect x='0' y='13' width='13' height='13' fill='#2a2a2c'/><rect x='13' y='13' width='13' height='13' fill='#1c1c1e'/><rect x='26' y='13' width='13' height='13' fill='#2a2a2c'/><rect x='13' y='26' width='13' height='13' fill='#2a2a2c'/></g><circle cx='145' cy='233' r='17' fill='#3d3d40'/>")
        }
    }

    fun skin_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"CLASSIC GREEN")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"SUI BLUE")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"RUBY RED")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"GRAPE PURPLE")
        } else {
            0x1::string::utf8(b"CARBON BLACK")
        }
    }

    fun slot_group_open(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"<g transform='translate(5.5,258) scale(2.0)'>")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"<g transform='translate(50.5,258) scale(2.0)'>")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"<g transform='translate(95.5,258) scale(2.0)'>")
        } else {
            0x1::string::utf8(b"<g transform='translate(140.5,258) scale(2.0)'>")
        }
    }

    public fun take_sticker(arg0: &mut Console, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::Sticker {
        assert!(arg1 < 4, 3);
        let v0 = StickerSlotKey{slot: arg1};
        assert!(0x2::dynamic_object_field::exists_<StickerSlotKey>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_object_field::remove<StickerSlotKey, 0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::Sticker>(&mut arg0.id, v0);
        arg0.image_uri = compose_image(arg0.skin_id, &arg0.id);
        let v2 = StickerDetached{
            console_id : 0x2::object::uid_to_address(&arg0.id),
            slot       : arg1,
            sticker_id : 0x2::object::id_address<0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::Sticker>(&v1),
        };
        0x2::event::emit<StickerDetached>(v2);
        v1
    }

    // decompiled from Move bytecode v7
}

