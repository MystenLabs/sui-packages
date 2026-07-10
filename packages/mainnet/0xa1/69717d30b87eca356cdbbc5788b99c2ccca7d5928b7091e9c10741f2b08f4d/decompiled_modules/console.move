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

    fun compose_image(arg0: u8, arg1: &0x2::object::UID) : 0x1::string::String {
        let v0 = skin_head(arg0);
        let v1 = 0;
        while (v1 < 4) {
            let v2 = StickerSlotKey{slot: v1};
            if (0x2::dynamic_object_field::exists_<StickerSlotKey>(arg1, v2)) {
                0x1::string::append(&mut v0, slot_group_open(v1));
                0x1::string::append(&mut v0, 0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::fragment(0x2::dynamic_object_field::borrow<StickerSlotKey, 0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker::Sticker>(arg1, v2)));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"%3C/g%3E"));
            };
            v1 = v1 + 1;
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(b"%3C/g%3E%3C/svg%3E"));
        v0
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
            0x1::string::utf8(b"data:image/svg+xml,%3Csvg viewBox='0 0 480 480' xmlns='http://www.w3.org/2000/svg' role='img'%3E%3Ctitle%3ESuiBoy Console - CLASSIC GREEN%3C/title%3E%3Crect width='480' height='480' fill='%23101016'/%3E%3Cg transform='translate(121.25,27.50) scale(1.25)'%3E%3ClinearGradient id='shellG' x1='0' y1='0' x2='0' y2='1'%3E%3Cstop offset='0' stop-color='%23c9cabb'/%3E%3Cstop offset='1' stop-color='%23adad9d'/%3E%3C/linearGradient%3E%3ClinearGradient id='bezelG' x1='0' y1='0' x2='0' y2='1'%3E%3Cstop offset='0' stop-color='%232a2a38'/%3E%3Cstop offset='1' stop-color='%2317171f'/%3E%3C/linearGradient%3E%3Cpath d='M16,0 L174,0 Q190,0 190,16 L190,308 Q190,340 158,340 L32,340 Q0,340 0,308 L0,16 Q0,0 16,0 Z' fill='url(%23shellG)'/%3E%3Ccircle cx='15' cy='15' r='3.2' fill='%23ff3b3b'/%3E%3Ctext x='174' y='18' font-size='9' font-weight='700' text-anchor='end' fill='%234b3a63' font-family='Georgia, serif' font-style='italic'%3ESuiBoy%3C/text%3E%3Crect x='11' y='28' width='168' height='168' rx='12' fill='url(%23bezelG)'/%3E%3Crect x='20' y='37' width='150' height='150' rx='6' fill='%239bbc0f'/%3E%3Cg opacity='0.12' stroke='%232f2340' stroke-width='1'%3E%3Cline x1='20' y1='67' x2='170' y2='67'/%3E%3Cline x1='20' y1='97' x2='170' y2='97'/%3E%3Cline x1='20' y1='127' x2='170' y2='127'/%3E%3Cline x1='20' y1='157' x2='170' y2='157'/%3E%3C/g%3E%3Cg transform='translate(26,214)'%3E%3Crect x='13' y='0' width='13' height='13' fill='%233c3250'/%3E%3Crect x='0' y='13' width='13' height='13' fill='%233c3250'/%3E%3Crect x='13' y='13' width='13' height='13' fill='%232c2438'/%3E%3Crect x='26' y='13' width='13' height='13' fill='%233c3250'/%3E%3Crect x='13' y='26' width='13' height='13' fill='%233c3250'/%3E%3C/g%3E%3Ccircle cx='148' cy='238' r='10' fill='%2352436b'/%3E%3Ccircle cx='166' cy='224' r='10' fill='%2352436b'/%3E%3Crect x='44' y='270' width='34' height='10' rx='5' fill='%233c3250'/%3E%3Crect x='112' y='270' width='34' height='10' rx='5' fill='%233c3250'/%3E")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"data:image/svg+xml,%3Csvg viewBox='0 0 480 480' xmlns='http://www.w3.org/2000/svg' role='img'%3E%3Ctitle%3ESuiBoy Console - SUI BLUE%3C/title%3E%3Crect width='480' height='480' fill='%23101016'/%3E%3Cg transform='translate(121.25,27.50) scale(1.25)'%3E%3ClinearGradient id='shellG' x1='0' y1='0' x2='0' y2='1'%3E%3Cstop offset='0' stop-color='%23bcd8ee'/%3E%3Cstop offset='1' stop-color='%238fb9d9'/%3E%3C/linearGradient%3E%3ClinearGradient id='bezelG' x1='0' y1='0' x2='0' y2='1'%3E%3Cstop offset='0' stop-color='%230b2036'/%3E%3Cstop offset='1' stop-color='%2304101c'/%3E%3C/linearGradient%3E%3Cpath d='M16,0 L174,0 Q190,0 190,16 L190,308 Q190,340 158,340 L32,340 Q0,340 0,308 L0,16 Q0,0 16,0 Z' fill='url(%23shellG)'/%3E%3Ccircle cx='15' cy='15' r='3.2' fill='%23ff3b3b'/%3E%3Ctext x='174' y='18' font-size='9' font-weight='700' text-anchor='end' fill='%230f4c85' font-family='Georgia, serif' font-style='italic'%3ESuiBoy%3C/text%3E%3Crect x='11' y='28' width='168' height='168' rx='12' fill='url(%23bezelG)'/%3E%3Crect x='20' y='37' width='150' height='150' rx='6' fill='%23bfe9ff'/%3E%3Cg opacity='0.12' stroke='%23062544' stroke-width='1'%3E%3Cline x1='20' y1='67' x2='170' y2='67'/%3E%3Cline x1='20' y1='97' x2='170' y2='97'/%3E%3Cline x1='20' y1='127' x2='170' y2='127'/%3E%3Cline x1='20' y1='157' x2='170' y2='157'/%3E%3C/g%3E%3Cg transform='translate(26,214)'%3E%3Crect x='13' y='0' width='13' height='13' fill='%23155187'/%3E%3Crect x='0' y='13' width='13' height='13' fill='%23155187'/%3E%3Crect x='13' y='13' width='13' height='13' fill='%230b3760'/%3E%3Crect x='26' y='13' width='13' height='13' fill='%23155187'/%3E%3Crect x='13' y='26' width='13' height='13' fill='%23155187'/%3E%3C/g%3E%3Ccircle cx='148' cy='238' r='10' fill='%231f6bb0'/%3E%3Ccircle cx='166' cy='224' r='10' fill='%231f6bb0'/%3E%3Crect x='44' y='270' width='34' height='10' rx='5' fill='%23155187'/%3E%3Crect x='112' y='270' width='34' height='10' rx='5' fill='%23155187'/%3E")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"data:image/svg+xml,%3Csvg viewBox='0 0 480 480' xmlns='http://www.w3.org/2000/svg' role='img'%3E%3Ctitle%3ESuiBoy Console - RUBY RED%3C/title%3E%3Crect width='480' height='480' fill='%23101016'/%3E%3Cg transform='translate(121.25,27.50) scale(1.25)'%3E%3ClinearGradient id='shellG' x1='0' y1='0' x2='0' y2='1'%3E%3Cstop offset='0' stop-color='%23e3b7bd'/%3E%3Cstop offset='1' stop-color='%23cf8f97'/%3E%3C/linearGradient%3E%3ClinearGradient id='bezelG' x1='0' y1='0' x2='0' y2='1'%3E%3Cstop offset='0' stop-color='%232c1013'/%3E%3Cstop offset='1' stop-color='%23180a0b'/%3E%3C/linearGradient%3E%3Cpath d='M16,0 L174,0 Q190,0 190,16 L190,308 Q190,340 158,340 L32,340 Q0,340 0,308 L0,16 Q0,0 16,0 Z' fill='url(%23shellG)'/%3E%3Ccircle cx='15' cy='15' r='3.2' fill='%23ff3b3b'/%3E%3Ctext x='174' y='18' font-size='9' font-weight='700' text-anchor='end' fill='%237a1f2b' font-family='Georgia, serif' font-style='italic'%3ESuiBoy%3C/text%3E%3Crect x='11' y='28' width='168' height='168' rx='12' fill='url(%23bezelG)'/%3E%3Crect x='20' y='37' width='150' height='150' rx='6' fill='%23ffd3d3'/%3E%3Cg opacity='0.12' stroke='%234a0f18' stroke-width='1'%3E%3Cline x1='20' y1='67' x2='170' y2='67'/%3E%3Cline x1='20' y1='97' x2='170' y2='97'/%3E%3Cline x1='20' y1='127' x2='170' y2='127'/%3E%3Cline x1='20' y1='157' x2='170' y2='157'/%3E%3C/g%3E%3Cg transform='translate(26,214)'%3E%3Crect x='13' y='0' width='13' height='13' fill='%236e1822'/%3E%3Crect x='0' y='13' width='13' height='13' fill='%236e1822'/%3E%3Crect x='13' y='13' width='13' height='13' fill='%23511119'/%3E%3Crect x='26' y='13' width='13' height='13' fill='%236e1822'/%3E%3Crect x='13' y='26' width='13' height='13' fill='%236e1822'/%3E%3C/g%3E%3Ccircle cx='148' cy='238' r='10' fill='%238f2733'/%3E%3Ccircle cx='166' cy='224' r='10' fill='%238f2733'/%3E%3Crect x='44' y='270' width='34' height='10' rx='5' fill='%236e1822'/%3E%3Crect x='112' y='270' width='34' height='10' rx='5' fill='%236e1822'/%3E")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"data:image/svg+xml,%3Csvg viewBox='0 0 480 480' xmlns='http://www.w3.org/2000/svg' role='img'%3E%3Ctitle%3ESuiBoy Console - GRAPE PURPLE%3C/title%3E%3Crect width='480' height='480' fill='%23101016'/%3E%3Cg transform='translate(121.25,27.50) scale(1.25)'%3E%3ClinearGradient id='shellG' x1='0' y1='0' x2='0' y2='1'%3E%3Cstop offset='0' stop-color='%23c9b8e0'/%3E%3Cstop offset='1' stop-color='%23a88fcb'/%3E%3C/linearGradient%3E%3ClinearGradient id='bezelG' x1='0' y1='0' x2='0' y2='1'%3E%3Cstop offset='0' stop-color='%231e1230'/%3E%3Cstop offset='1' stop-color='%230f091a'/%3E%3C/linearGradient%3E%3Cpath d='M16,0 L174,0 Q190,0 190,16 L190,308 Q190,340 158,340 L32,340 Q0,340 0,308 L0,16 Q0,0 16,0 Z' fill='url(%23shellG)'/%3E%3Ccircle cx='15' cy='15' r='3.2' fill='%23ff3b3b'/%3E%3Ctext x='174' y='18' font-size='9' font-weight='700' text-anchor='end' fill='%234b1f7a' font-family='Georgia, serif' font-style='italic'%3ESuiBoy%3C/text%3E%3Crect x='11' y='28' width='168' height='168' rx='12' fill='url(%23bezelG)'/%3E%3Crect x='20' y='37' width='150' height='150' rx='6' fill='%23dcc6ff'/%3E%3Cg opacity='0.12' stroke='%232c0f4a' stroke-width='1'%3E%3Cline x1='20' y1='67' x2='170' y2='67'/%3E%3Cline x1='20' y1='97' x2='170' y2='97'/%3E%3Cline x1='20' y1='127' x2='170' y2='127'/%3E%3Cline x1='20' y1='157' x2='170' y2='157'/%3E%3C/g%3E%3Cg transform='translate(26,214)'%3E%3Crect x='13' y='0' width='13' height='13' fill='%2342206b'/%3E%3Crect x='0' y='13' width='13' height='13' fill='%2342206b'/%3E%3Crect x='13' y='13' width='13' height='13' fill='%232f1450'/%3E%3Crect x='26' y='13' width='13' height='13' fill='%2342206b'/%3E%3Crect x='13' y='26' width='13' height='13' fill='%2342206b'/%3E%3C/g%3E%3Ccircle cx='148' cy='238' r='10' fill='%2354277f'/%3E%3Ccircle cx='166' cy='224' r='10' fill='%2354277f'/%3E%3Crect x='44' y='270' width='34' height='10' rx='5' fill='%2342206b'/%3E%3Crect x='112' y='270' width='34' height='10' rx='5' fill='%2342206b'/%3E")
        } else {
            0x1::string::utf8(b"data:image/svg+xml,%3Csvg viewBox='0 0 480 480' xmlns='http://www.w3.org/2000/svg' role='img'%3E%3Ctitle%3ESuiBoy Console - CARBON BLACK%3C/title%3E%3Crect width='480' height='480' fill='%23101016'/%3E%3Cg transform='translate(121.25,27.50) scale(1.25)'%3E%3ClinearGradient id='shellG' x1='0' y1='0' x2='0' y2='1'%3E%3Cstop offset='0' stop-color='%233a3a3d'/%3E%3Cstop offset='1' stop-color='%23232325'/%3E%3C/linearGradient%3E%3ClinearGradient id='bezelG' x1='0' y1='0' x2='0' y2='1'%3E%3Cstop offset='0' stop-color='%230d0d0e'/%3E%3Cstop offset='1' stop-color='%23000000'/%3E%3C/linearGradient%3E%3Cpath d='M16,0 L174,0 Q190,0 190,16 L190,308 Q190,340 158,340 L32,340 Q0,340 0,308 L0,16 Q0,0 16,0 Z' fill='url(%23shellG)'/%3E%3Ccircle cx='15' cy='15' r='3.2' fill='%23ff3b3b'/%3E%3Ctext x='174' y='18' font-size='9' font-weight='700' text-anchor='end' fill='%23ffb000' font-family='Georgia, serif' font-style='italic'%3ESuiBoy%3C/text%3E%3Crect x='11' y='28' width='168' height='168' rx='12' fill='url(%23bezelG)'/%3E%3Crect x='20' y='37' width='150' height='150' rx='6' fill='%232b1a05'/%3E%3Cg opacity='0.12' stroke='%23eef0f5' stroke-width='1'%3E%3Cline x1='20' y1='67' x2='170' y2='67'/%3E%3Cline x1='20' y1='97' x2='170' y2='97'/%3E%3Cline x1='20' y1='127' x2='170' y2='127'/%3E%3Cline x1='20' y1='157' x2='170' y2='157'/%3E%3C/g%3E%3Cg transform='translate(26,214)'%3E%3Crect x='13' y='0' width='13' height='13' fill='%232a2a2c'/%3E%3Crect x='0' y='13' width='13' height='13' fill='%232a2a2c'/%3E%3Crect x='13' y='13' width='13' height='13' fill='%231c1c1e'/%3E%3Crect x='26' y='13' width='13' height='13' fill='%232a2a2c'/%3E%3Crect x='13' y='26' width='13' height='13' fill='%232a2a2c'/%3E%3C/g%3E%3Ccircle cx='148' cy='238' r='10' fill='%233d3d40'/%3E%3Ccircle cx='166' cy='224' r='10' fill='%233d3d40'/%3E%3Crect x='44' y='270' width='34' height='10' rx='5' fill='%232a2a2c'/%3E%3Crect x='112' y='270' width='34' height='10' rx='5' fill='%232a2a2c'/%3E")
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
            0x1::string::utf8(b"%3Cg transform='translate(15,290) scale(1.2)'%3E")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"%3Cg transform='translate(57,290) scale(1.2)'%3E")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"%3Cg transform='translate(99,290) scale(1.2)'%3E")
        } else {
            0x1::string::utf8(b"%3Cg transform='translate(141,290) scale(1.2)'%3E")
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

