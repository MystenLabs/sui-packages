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

    struct ConsoleMinted has copy, drop {
        console_id: address,
        number: u64,
        skin_id: u8,
        minter: address,
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
        let (v3, v4) = skin_data(v2);
        let v5 = Console{
            id        : 0x2::object::new(arg3),
            number    : v0,
            skin_id   : v2,
            skin_name : v3,
            image_uri : v4,
        };
        let v6 = ConsoleMinted{
            console_id : 0x2::object::uid_to_address(&v5.id),
            number     : v0,
            skin_id    : v2,
            minter     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ConsoleMinted>(v6);
        0x2::transfer::public_transfer<Console>(v5, 0x2::tx_context::sender(arg3));
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

    fun skin_data(arg0: u8) : (0x1::string::String, 0x1::string::String) {
        if (arg0 == 0) {
            (0x1::string::utf8(b"CLASSIC GREEN"), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgNDgwIDQ4MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiByb2xlPSJpbWciPjx0aXRsZT5TdWlCb3kgQ29uc29sZSAtIENMQVNTSUMgR1JFRU48L3RpdGxlPjxyZWN0IHdpZHRoPSI0ODAiIGhlaWdodD0iNDgwIiBmaWxsPSIjMTAxMDE2Ii8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoOTAuMDAsNTIuNTApIHNjYWxlKDEuMjUpIj48bGluZWFyR3JhZGllbnQgaWQ9InNoZWxsRyIgeDE9IjAiIHkxPSIwIiB4Mj0iMCIgeTI9IjEiPjxzdG9wIG9mZnNldD0iMCIgc3RvcC1jb2xvcj0iI2M5Y2FiYiIvPjxzdG9wIG9mZnNldD0iMSIgc3RvcC1jb2xvcj0iI2FkYWQ5ZCIvPjwvbGluZWFyR3JhZGllbnQ+PGxpbmVhckdyYWRpZW50IGlkPSJiZXplbEciIHgxPSIwIiB5MT0iMCIgeDI9IjAiIHkyPSIxIj48c3RvcCBvZmZzZXQ9IjAiIHN0b3AtY29sb3I9IiMyYTJhMzgiLz48c3RvcCBvZmZzZXQ9IjEiIHN0b3AtY29sb3I9IiMxNzE3MWYiLz48L2xpbmVhckdyYWRpZW50PjxyZWN0IHg9IjAiIHk9IjAiIHdpZHRoPSIyNDAiIGhlaWdodD0iMzAwIiByeD0iMjAiIGZpbGw9InVybCgjc2hlbGxHKSIvPjxjaXJjbGUgY3g9IjE4IiBjeT0iMTgiIHI9IjQiIGZpbGw9IiNmZjNiM2IiLz48dGV4dCB4PSIyMjYiIHk9IjIyIiBmb250LXNpemU9IjExIiBmb250LXdlaWdodD0iNzAwIiB0ZXh0LWFuY2hvcj0iZW5kIiBmaWxsPSIjNGIzYTYzIiBmb250LWZhbWlseT0iR2VvcmdpYSwgc2VyaWYiIGZvbnQtc3R5bGU9Iml0YWxpYyI+U3VpQm95PC90ZXh0PjxyZWN0IHg9IjE0IiB5PSIzNCIgd2lkdGg9IjIxMiIgaGVpZ2h0PSIxNTAiIHJ4PSIxMCIgZmlsbD0idXJsKCNiZXplbEcpIi8+PHJlY3QgeD0iMjQiIHk9IjQ0IiB3aWR0aD0iMTkyIiBoZWlnaHQ9IjEzMCIgcng9IjQiIGZpbGw9IiM5YmJjMGYiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgzOCwyMTApIj48cmVjdCB4PSIxNCIgeT0iMCIgd2lkdGg9IjE0IiBoZWlnaHQ9IjE0IiBmaWxsPSIjM2MzMjUwIi8+PHJlY3QgeD0iMCIgeT0iMTQiIHdpZHRoPSIxNCIgaGVpZ2h0PSIxNCIgZmlsbD0iIzNjMzI1MCIvPjxyZWN0IHg9IjE0IiB5PSIxNCIgd2lkdGg9IjE0IiBoZWlnaHQ9IjE0IiBmaWxsPSIjMmMyNDM4Ii8+PHJlY3QgeD0iMjgiIHk9IjE0IiB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIGZpbGw9IiMzYzMyNTAiLz48cmVjdCB4PSIxNCIgeT0iMjgiIHdpZHRoPSIxNCIgaGVpZ2h0PSIxNCIgZmlsbD0iIzNjMzI1MCIvPjwvZz48Y2lyY2xlIGN4PSIxODgiIGN5PSIyMzQiIHI9IjExIiBmaWxsPSIjNTI0MzZiIi8+PGNpcmNsZSBjeD0iMjEwIiBjeT0iMjIyIiByPSIxMSIgZmlsbD0iIzUyNDM2YiIvPjx0ZXh0IHg9IjEyMC4wIiB5PSIyNzgiIGZvbnQtc2l6ZT0iMTQiIGZvbnQtd2VpZ2h0PSI3MDAiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGZpbGw9IiMyZjIzNDAiIGxldHRlci1zcGFjaW5nPSIwLjUiPkNMQVNTSUMgR1JFRU48L3RleHQ+PHRleHQgeD0iMTIwLjAiIHk9IjI5MyIgZm9udC1zaXplPSI5IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjMmYyMzQwIiBvcGFjaXR5PSIwLjY1IiBsZXR0ZXItc3BhY2luZz0iMSI+U1VJQk9ZIENPTlNPTEU8L3RleHQ+PC9nPjwvc3ZnPg=="))
        } else if (arg0 == 1) {
            (0x1::string::utf8(b"SUI BLUE"), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgNDgwIDQ4MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiByb2xlPSJpbWciPjx0aXRsZT5TdWlCb3kgQ29uc29sZSAtIFNVSSBCTFVFPC90aXRsZT48cmVjdCB3aWR0aD0iNDgwIiBoZWlnaHQ9IjQ4MCIgZmlsbD0iIzEwMTAxNiIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDkwLjAwLDUyLjUwKSBzY2FsZSgxLjI1KSI+PGxpbmVhckdyYWRpZW50IGlkPSJzaGVsbEciIHgxPSIwIiB5MT0iMCIgeDI9IjAiIHkyPSIxIj48c3RvcCBvZmZzZXQ9IjAiIHN0b3AtY29sb3I9IiNiY2Q4ZWUiLz48c3RvcCBvZmZzZXQ9IjEiIHN0b3AtY29sb3I9IiM4ZmI5ZDkiLz48L2xpbmVhckdyYWRpZW50PjxsaW5lYXJHcmFkaWVudCBpZD0iYmV6ZWxHIiB4MT0iMCIgeTE9IjAiIHgyPSIwIiB5Mj0iMSI+PHN0b3Agb2Zmc2V0PSIwIiBzdG9wLWNvbG9yPSIjMGIyMDM2Ii8+PHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSIjMDQxMDFjIi8+PC9saW5lYXJHcmFkaWVudD48cmVjdCB4PSIwIiB5PSIwIiB3aWR0aD0iMjQwIiBoZWlnaHQ9IjMwMCIgcng9IjIwIiBmaWxsPSJ1cmwoI3NoZWxsRykiLz48Y2lyY2xlIGN4PSIxOCIgY3k9IjE4IiByPSI0IiBmaWxsPSIjZmYzYjNiIi8+PHRleHQgeD0iMjI2IiB5PSIyMiIgZm9udC1zaXplPSIxMSIgZm9udC13ZWlnaHQ9IjcwMCIgdGV4dC1hbmNob3I9ImVuZCIgZmlsbD0iIzBmNGM4NSIgZm9udC1mYW1pbHk9Ikdlb3JnaWEsIHNlcmlmIiBmb250LXN0eWxlPSJpdGFsaWMiPlN1aUJveTwvdGV4dD48cmVjdCB4PSIxNCIgeT0iMzQiIHdpZHRoPSIyMTIiIGhlaWdodD0iMTUwIiByeD0iMTAiIGZpbGw9InVybCgjYmV6ZWxHKSIvPjxyZWN0IHg9IjI0IiB5PSI0NCIgd2lkdGg9IjE5MiIgaGVpZ2h0PSIxMzAiIHJ4PSI0IiBmaWxsPSIjYmZlOWZmIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMzgsMjEwKSI+PHJlY3QgeD0iMTQiIHk9IjAiIHdpZHRoPSIxNCIgaGVpZ2h0PSIxNCIgZmlsbD0iIzE1NTE4NyIvPjxyZWN0IHg9IjAiIHk9IjE0IiB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIGZpbGw9IiMxNTUxODciLz48cmVjdCB4PSIxNCIgeT0iMTQiIHdpZHRoPSIxNCIgaGVpZ2h0PSIxNCIgZmlsbD0iIzBiMzc2MCIvPjxyZWN0IHg9IjI4IiB5PSIxNCIgd2lkdGg9IjE0IiBoZWlnaHQ9IjE0IiBmaWxsPSIjMTU1MTg3Ii8+PHJlY3QgeD0iMTQiIHk9IjI4IiB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIGZpbGw9IiMxNTUxODciLz48L2c+PGNpcmNsZSBjeD0iMTg4IiBjeT0iMjM0IiByPSIxMSIgZmlsbD0iIzFmNmJiMCIvPjxjaXJjbGUgY3g9IjIxMCIgY3k9IjIyMiIgcj0iMTEiIGZpbGw9IiMxZjZiYjAiLz48dGV4dCB4PSIxMjAuMCIgeT0iMjc4IiBmb250LXNpemU9IjE0IiBmb250LXdlaWdodD0iNzAwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjMDYyNTQ0IiBsZXR0ZXItc3BhY2luZz0iMC41Ij5TVUkgQkxVRTwvdGV4dD48dGV4dCB4PSIxMjAuMCIgeT0iMjkzIiBmb250LXNpemU9IjkiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGZpbGw9IiMwNjI1NDQiIG9wYWNpdHk9IjAuNjUiIGxldHRlci1zcGFjaW5nPSIxIj5TVUlCT1kgQ09OU09MRTwvdGV4dD48L2c+PC9zdmc+"))
        } else if (arg0 == 2) {
            (0x1::string::utf8(b"RUBY RED"), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgNDgwIDQ4MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiByb2xlPSJpbWciPjx0aXRsZT5TdWlCb3kgQ29uc29sZSAtIFJVQlkgUkVEPC90aXRsZT48cmVjdCB3aWR0aD0iNDgwIiBoZWlnaHQ9IjQ4MCIgZmlsbD0iIzEwMTAxNiIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDkwLjAwLDUyLjUwKSBzY2FsZSgxLjI1KSI+PGxpbmVhckdyYWRpZW50IGlkPSJzaGVsbEciIHgxPSIwIiB5MT0iMCIgeDI9IjAiIHkyPSIxIj48c3RvcCBvZmZzZXQ9IjAiIHN0b3AtY29sb3I9IiNlM2I3YmQiLz48c3RvcCBvZmZzZXQ9IjEiIHN0b3AtY29sb3I9IiNjZjhmOTciLz48L2xpbmVhckdyYWRpZW50PjxsaW5lYXJHcmFkaWVudCBpZD0iYmV6ZWxHIiB4MT0iMCIgeTE9IjAiIHgyPSIwIiB5Mj0iMSI+PHN0b3Agb2Zmc2V0PSIwIiBzdG9wLWNvbG9yPSIjMmMxMDEzIi8+PHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSIjMTgwYTBiIi8+PC9saW5lYXJHcmFkaWVudD48cmVjdCB4PSIwIiB5PSIwIiB3aWR0aD0iMjQwIiBoZWlnaHQ9IjMwMCIgcng9IjIwIiBmaWxsPSJ1cmwoI3NoZWxsRykiLz48Y2lyY2xlIGN4PSIxOCIgY3k9IjE4IiByPSI0IiBmaWxsPSIjZmYzYjNiIi8+PHRleHQgeD0iMjI2IiB5PSIyMiIgZm9udC1zaXplPSIxMSIgZm9udC13ZWlnaHQ9IjcwMCIgdGV4dC1hbmNob3I9ImVuZCIgZmlsbD0iIzdhMWYyYiIgZm9udC1mYW1pbHk9Ikdlb3JnaWEsIHNlcmlmIiBmb250LXN0eWxlPSJpdGFsaWMiPlN1aUJveTwvdGV4dD48cmVjdCB4PSIxNCIgeT0iMzQiIHdpZHRoPSIyMTIiIGhlaWdodD0iMTUwIiByeD0iMTAiIGZpbGw9InVybCgjYmV6ZWxHKSIvPjxyZWN0IHg9IjI0IiB5PSI0NCIgd2lkdGg9IjE5MiIgaGVpZ2h0PSIxMzAiIHJ4PSI0IiBmaWxsPSIjZmZkM2QzIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMzgsMjEwKSI+PHJlY3QgeD0iMTQiIHk9IjAiIHdpZHRoPSIxNCIgaGVpZ2h0PSIxNCIgZmlsbD0iIzZlMTgyMiIvPjxyZWN0IHg9IjAiIHk9IjE0IiB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIGZpbGw9IiM2ZTE4MjIiLz48cmVjdCB4PSIxNCIgeT0iMTQiIHdpZHRoPSIxNCIgaGVpZ2h0PSIxNCIgZmlsbD0iIzUxMTExOSIvPjxyZWN0IHg9IjI4IiB5PSIxNCIgd2lkdGg9IjE0IiBoZWlnaHQ9IjE0IiBmaWxsPSIjNmUxODIyIi8+PHJlY3QgeD0iMTQiIHk9IjI4IiB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIGZpbGw9IiM2ZTE4MjIiLz48L2c+PGNpcmNsZSBjeD0iMTg4IiBjeT0iMjM0IiByPSIxMSIgZmlsbD0iIzhmMjczMyIvPjxjaXJjbGUgY3g9IjIxMCIgY3k9IjIyMiIgcj0iMTEiIGZpbGw9IiM4ZjI3MzMiLz48dGV4dCB4PSIxMjAuMCIgeT0iMjc4IiBmb250LXNpemU9IjE0IiBmb250LXdlaWdodD0iNzAwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjNGEwZjE4IiBsZXR0ZXItc3BhY2luZz0iMC41Ij5SVUJZIFJFRDwvdGV4dD48dGV4dCB4PSIxMjAuMCIgeT0iMjkzIiBmb250LXNpemU9IjkiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGZpbGw9IiM0YTBmMTgiIG9wYWNpdHk9IjAuNjUiIGxldHRlci1zcGFjaW5nPSIxIj5TVUlCT1kgQ09OU09MRTwvdGV4dD48L2c+PC9zdmc+"))
        } else if (arg0 == 3) {
            (0x1::string::utf8(b"GRAPE PURPLE"), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgNDgwIDQ4MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiByb2xlPSJpbWciPjx0aXRsZT5TdWlCb3kgQ29uc29sZSAtIEdSQVBFIFBVUlBMRTwvdGl0bGU+PHJlY3Qgd2lkdGg9IjQ4MCIgaGVpZ2h0PSI0ODAiIGZpbGw9IiMxMDEwMTYiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg5MC4wMCw1Mi41MCkgc2NhbGUoMS4yNSkiPjxsaW5lYXJHcmFkaWVudCBpZD0ic2hlbGxHIiB4MT0iMCIgeTE9IjAiIHgyPSIwIiB5Mj0iMSI+PHN0b3Agb2Zmc2V0PSIwIiBzdG9wLWNvbG9yPSIjYzliOGUwIi8+PHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSIjYTg4ZmNiIi8+PC9saW5lYXJHcmFkaWVudD48bGluZWFyR3JhZGllbnQgaWQ9ImJlemVsRyIgeDE9IjAiIHkxPSIwIiB4Mj0iMCIgeTI9IjEiPjxzdG9wIG9mZnNldD0iMCIgc3RvcC1jb2xvcj0iIzFlMTIzMCIvPjxzdG9wIG9mZnNldD0iMSIgc3RvcC1jb2xvcj0iIzBmMDkxYSIvPjwvbGluZWFyR3JhZGllbnQ+PHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjI0MCIgaGVpZ2h0PSIzMDAiIHJ4PSIyMCIgZmlsbD0idXJsKCNzaGVsbEcpIi8+PGNpcmNsZSBjeD0iMTgiIGN5PSIxOCIgcj0iNCIgZmlsbD0iI2ZmM2IzYiIvPjx0ZXh0IHg9IjIyNiIgeT0iMjIiIGZvbnQtc2l6ZT0iMTEiIGZvbnQtd2VpZ2h0PSI3MDAiIHRleHQtYW5jaG9yPSJlbmQiIGZpbGw9IiM0YjFmN2EiIGZvbnQtZmFtaWx5PSJHZW9yZ2lhLCBzZXJpZiIgZm9udC1zdHlsZT0iaXRhbGljIj5TdWlCb3k8L3RleHQ+PHJlY3QgeD0iMTQiIHk9IjM0IiB3aWR0aD0iMjEyIiBoZWlnaHQ9IjE1MCIgcng9IjEwIiBmaWxsPSJ1cmwoI2JlemVsRykiLz48cmVjdCB4PSIyNCIgeT0iNDQiIHdpZHRoPSIxOTIiIGhlaWdodD0iMTMwIiByeD0iNCIgZmlsbD0iI2RjYzZmZiIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDM4LDIxMCkiPjxyZWN0IHg9IjE0IiB5PSIwIiB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIGZpbGw9IiM0MjIwNmIiLz48cmVjdCB4PSIwIiB5PSIxNCIgd2lkdGg9IjE0IiBoZWlnaHQ9IjE0IiBmaWxsPSIjNDIyMDZiIi8+PHJlY3QgeD0iMTQiIHk9IjE0IiB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIGZpbGw9IiMyZjE0NTAiLz48cmVjdCB4PSIyOCIgeT0iMTQiIHdpZHRoPSIxNCIgaGVpZ2h0PSIxNCIgZmlsbD0iIzQyMjA2YiIvPjxyZWN0IHg9IjE0IiB5PSIyOCIgd2lkdGg9IjE0IiBoZWlnaHQ9IjE0IiBmaWxsPSIjNDIyMDZiIi8+PC9nPjxjaXJjbGUgY3g9IjE4OCIgY3k9IjIzNCIgcj0iMTEiIGZpbGw9IiM1NDI3N2YiLz48Y2lyY2xlIGN4PSIyMTAiIGN5PSIyMjIiIHI9IjExIiBmaWxsPSIjNTQyNzdmIi8+PHRleHQgeD0iMTIwLjAiIHk9IjI3OCIgZm9udC1zaXplPSIxNCIgZm9udC13ZWlnaHQ9IjcwMCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzJjMGY0YSIgbGV0dGVyLXNwYWNpbmc9IjAuNSI+R1JBUEUgUFVSUExFPC90ZXh0Pjx0ZXh0IHg9IjEyMC4wIiB5PSIyOTMiIGZvbnQtc2l6ZT0iOSIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzJjMGY0YSIgb3BhY2l0eT0iMC42NSIgbGV0dGVyLXNwYWNpbmc9IjEiPlNVSUJPWSBDT05TT0xFPC90ZXh0PjwvZz48L3N2Zz4="))
        } else {
            (0x1::string::utf8(b"CARBON BLACK"), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgNDgwIDQ4MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiByb2xlPSJpbWciPjx0aXRsZT5TdWlCb3kgQ29uc29sZSAtIENBUkJPTiBCTEFDSzwvdGl0bGU+PHJlY3Qgd2lkdGg9IjQ4MCIgaGVpZ2h0PSI0ODAiIGZpbGw9IiMxMDEwMTYiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg5MC4wMCw1Mi41MCkgc2NhbGUoMS4yNSkiPjxsaW5lYXJHcmFkaWVudCBpZD0ic2hlbGxHIiB4MT0iMCIgeTE9IjAiIHgyPSIwIiB5Mj0iMSI+PHN0b3Agb2Zmc2V0PSIwIiBzdG9wLWNvbG9yPSIjM2EzYTNkIi8+PHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSIjMjMyMzI1Ii8+PC9saW5lYXJHcmFkaWVudD48bGluZWFyR3JhZGllbnQgaWQ9ImJlemVsRyIgeDE9IjAiIHkxPSIwIiB4Mj0iMCIgeTI9IjEiPjxzdG9wIG9mZnNldD0iMCIgc3RvcC1jb2xvcj0iIzBkMGQwZSIvPjxzdG9wIG9mZnNldD0iMSIgc3RvcC1jb2xvcj0iIzAwMDAwMCIvPjwvbGluZWFyR3JhZGllbnQ+PHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjI0MCIgaGVpZ2h0PSIzMDAiIHJ4PSIyMCIgZmlsbD0idXJsKCNzaGVsbEcpIi8+PGNpcmNsZSBjeD0iMTgiIGN5PSIxOCIgcj0iNCIgZmlsbD0iI2ZmM2IzYiIvPjx0ZXh0IHg9IjIyNiIgeT0iMjIiIGZvbnQtc2l6ZT0iMTEiIGZvbnQtd2VpZ2h0PSI3MDAiIHRleHQtYW5jaG9yPSJlbmQiIGZpbGw9IiNmZmIwMDAiIGZvbnQtZmFtaWx5PSJHZW9yZ2lhLCBzZXJpZiIgZm9udC1zdHlsZT0iaXRhbGljIj5TdWlCb3k8L3RleHQ+PHJlY3QgeD0iMTQiIHk9IjM0IiB3aWR0aD0iMjEyIiBoZWlnaHQ9IjE1MCIgcng9IjEwIiBmaWxsPSJ1cmwoI2JlemVsRykiLz48cmVjdCB4PSIyNCIgeT0iNDQiIHdpZHRoPSIxOTIiIGhlaWdodD0iMTMwIiByeD0iNCIgZmlsbD0iIzJiMWEwNSIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDM4LDIxMCkiPjxyZWN0IHg9IjE0IiB5PSIwIiB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIGZpbGw9IiMyYTJhMmMiLz48cmVjdCB4PSIwIiB5PSIxNCIgd2lkdGg9IjE0IiBoZWlnaHQ9IjE0IiBmaWxsPSIjMmEyYTJjIi8+PHJlY3QgeD0iMTQiIHk9IjE0IiB3aWR0aD0iMTQiIGhlaWdodD0iMTQiIGZpbGw9IiMxYzFjMWUiLz48cmVjdCB4PSIyOCIgeT0iMTQiIHdpZHRoPSIxNCIgaGVpZ2h0PSIxNCIgZmlsbD0iIzJhMmEyYyIvPjxyZWN0IHg9IjE0IiB5PSIyOCIgd2lkdGg9IjE0IiBoZWlnaHQ9IjE0IiBmaWxsPSIjMmEyYTJjIi8+PC9nPjxjaXJjbGUgY3g9IjE4OCIgY3k9IjIzNCIgcj0iMTEiIGZpbGw9IiMzZDNkNDAiLz48Y2lyY2xlIGN4PSIyMTAiIGN5PSIyMjIiIHI9IjExIiBmaWxsPSIjM2QzZDQwIi8+PHRleHQgeD0iMTIwLjAiIHk9IjI3OCIgZm9udC1zaXplPSIxNCIgZm9udC13ZWlnaHQ9IjcwMCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iI2VlZjBmNSIgbGV0dGVyLXNwYWNpbmc9IjAuNSI+Q0FSQk9OIEJMQUNLPC90ZXh0Pjx0ZXh0IHg9IjEyMC4wIiB5PSIyOTMiIGZvbnQtc2l6ZT0iOSIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iI2VlZjBmNSIgb3BhY2l0eT0iMC42NSIgbGV0dGVyLXNwYWNpbmc9IjEiPlNVSUJPWSBDT05TT0xFPC90ZXh0PjwvZz48L3N2Zz4="))
        }
    }

    // decompiled from Move bytecode v7
}

